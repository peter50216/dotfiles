#!/bin/bash
set -e
set -o noclobber

temp_files=()

cleanup() {
  for file in "${temp_files[@]}"; do
    rm -rf "${file}"
  done
}

info() {
  printf "\e[1;33m%s\e[m\n" "$*"
}

die() {
  printf "\e[1;31mERROR: %s\e[m\n" "$*" >&2
  cleanup
  exit 1
}

atomic_file() {
  { true > "$1" ; } &> /dev/null
}

atomic_directory() {
  mkdir -- "$1" 2>/dev/null
}

replace() {
  # mv -T is not supported on BSD :(
  local temp_dir
  temp_dir=$(mktemp -d tmp.unarchive.XXXXXXXXXX)
  temp_files+=(${temp_dir})
  mv -- "$1" "$temp_dir/$2"
  mv -- "$temp_dir/$2" .
}

find_unique_name() {
  local orig_name="$1"
  local file_type="$2"
  local name="${orig_name}"
  local ext=""
  if [[ ${file_type} == "file" ]]; then
    ext=""
    name="${name%.*}"
    if [[ "${orig_name}" != "${name}" ]]; then
      ext=".${orig_name##*.}"
    fi
  fi

  if "atomic_${file_type}" "${name}${ext}"; then
    echo "${name}${ext}"
    return
  fi

  local num=2
  while ! "atomic_${file_type}" "${name}_${num}${ext}"; do
    ((num++))
  done
  echo "${name}_${num}${ext}"
}

unarchive_zip() {
  unzip -d "$2" -- "$1"
}

unarchive_tgz() {
  if type pigz >/dev/null 2>&1; then
    tar --use-compress-program pigz -xvf "$1" -C "$2"
  else
    tar -xvzf "$1" -C "$2"
  fi
}

unarchive_txz() {
  if type pixz >/dev/null 2>&1; then
    tar --use-compress-program pixz -xvf "$1" -C "$2"
  else
    tar --xz -xvf "$1" -C "$2"
  fi
}

unarchive_tbz2() {
  tar -xvjf "$1" -C "$2"
}

unarchive_7z() {
  7za x -o"$2" -- "$1"
}

unarchive_tar() {
  tar -xvf "$1" -C "$2"
}

unarchive_zst() {
  local input_file="$1"
  local output_folder="$2"

  local base_name_with_ext
  base_name_with_ext=$(basename "$input_file")

  # Remove the .zst extension to get the target filename (e.g., my_archive.txt)
  output_filename="${base_name_with_ext%.zst}"

  # Construct the full output path
  local output_path="$output_folder/$output_filename"

  zstd -d "$input_file" -o "$output_path"
}

unarchive() {
  local archive_orig_path="$1"
  if [[ ! -f "${archive_orig_path}" ]]; then
    die "${archive_orig_path}: archive doesn't exist."
  fi

  local archive
  archive="$(basename "${archive_orig_path}")"

  local archive_type
  local archive_basename="${archive%.*}"

  case "${archive}" in
    *.zip)
      archive_type=zip
      ;;
    *.tar)
      archive_type=tar
      ;;
    *.tar.gz)
      archive_type=tgz
      archive_basename="${archive%.tar.gz}"
      ;;
    *.tgz)
      archive_type=tgz
      ;;
    *.tar.xz)
      archive_type=txz
      archive_basename="${archive%.tar.xz}"
      ;;
    *.txz)
      archive_type=txz
      ;;
    *.tar.bz2)
      archive_type=tbz2
      archive_basename="${archive%.tar.bz2}"
      ;;
    *.tbz|*.tbz2)
      archive_type=tbz2
      ;;
    *.7z)
      archive_type=7z
      ;;
    *.zst)
      archive_type=zst
      ;;
    *)
      die "Unknown archive: ${archive_orig_path}"
  esac

  local temp_dir
  temp_dir=$(mktemp -d tmp.unarchive.XXXXXXXXXX)
  temp_files+=(${temp_dir})

  "unarchive_${archive_type}" "${archive_orig_path}" "${temp_dir}"

  local sub_files=()
  while IFS= read -r -d '' f; do
    sub_files+=("$f")
  done < <(find "${temp_dir}" -maxdepth 1 -mindepth 1 -print0)

  if (( "${#sub_files[@]}" == 0 )); then
    info "${archive_orig_path}: No file in archive!"
    return
  fi

  local target
  if (( "${#sub_files[@]}" == 1 )); then
    local file="${sub_files[0]}"
    local file_type
    file_type=$([[ -f "${file}" ]] && echo "file" || echo "directory")
    target="$(find_unique_name "$(basename "${file}")" "${file_type}")"
    replace "${file}" "${target}"
    info "${archive_orig_path}: Single ${file_type}, moved to ${target}"
  else
    target="$(find_unique_name "${archive_basename}" "directory")"
    replace "${temp_dir}" "${target}"
    info "${archive_orig_path}: Extracted to ${target}"
  fi
}

main() {
  trap cleanup EXIT
  if (( $# == 0 )); then
    echo "Usage: $0 [archive files]"
    exit 1
  fi
  while (( $# > 0 )); do
    unarchive "$1"
    shift
  done
}
main "$@"
