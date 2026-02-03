///|
test {
  let lib = DynamicLibrary::open("libm.dylib")
  let cos_ptr : @c.Pointer[Unit] = lib.symbol("cos")
  let cos_fn : FuncRef[(Double) -> Double] = cos_ptr.unsafe_into()
  inspect(
    cos_fn(0.0),
    content=(
      #|1
    ),
  )
}
