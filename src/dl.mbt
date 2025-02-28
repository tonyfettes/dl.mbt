///|
extern type DynamicLibrary

///|
type! DynamicLibraryError String derive(Show)

///|
extern "c" fn DynamicLibrary::open_(
  path : Bytes,
  flags : Int
) -> Nullable[DynamicLibrary] = "moonbit_dlopen"

///|
extern "c" fn DynamicLibrary::error() -> Nullable[Bytes] = "moonbit_dlerror"

///|
pub const RTLD_LAZY = 0x1

///|
pub const RTLD_NOW = 0x2

///|
pub fn DynamicLibrary::open(
  path : String,
  flags : Int
) -> DynamicLibrary!DynamicLibraryError {
  let path_bytes = @buffer.new()
  path_bytes.write_bytes(@encoding.encode(UTF8, path))
  path_bytes.write_byte(0)
  let library = DynamicLibrary::open_(path_bytes.contents(), flags)
  if library.is_none() {
    let bytes = DynamicLibrary::error().unwrap()
    let message = @encoding.decode_lossy(UTF8, bytes).to_string()
    raise DynamicLibraryError(message)
  }
  library.unwrap()
}

///|
pub extern "c" fn DynamicLibrary::close(self : DynamicLibrary) = "moonbit_dlclose"
