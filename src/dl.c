#include <moonbit.h>

void *
moonbit_dlopen(moonbit_bytes_t filename, int flag) {
  void *handle = dlopen((const char *)filename, flag);
  printf("dlopen: %p\n", handle);
  moonbit_decref(filename);
  return handle;
}

void *
moonbit_dlsym(void *handle, moonbit_bytes_t symbol) {
  void *ptr = dlsym(handle, (const char *)symbol);
  printf("dlsym: %p\n", ptr);
  moonbit_decref(symbol);
  return ptr;
}

moonbit_bytes_t
moonbit_dlerror() {
  const char *error = dlerror();
  size_t length = strlen(error);
  moonbit_bytes_t bytes = moonbit_make_bytes(length, 0);
  memcpy(bytes, error, length);
  return bytes;
}

void
moonbit_dlclose(void *handle) {
  dlclose(handle);
}
