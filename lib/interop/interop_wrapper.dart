
abstract class InteropWrapper <T> {
  T _inteop;
  // I name it myself because I want to avoid collisions with the real methods of the interop object (while also providing clarity of what the method does).
  void setWrappedInteropObject(T obj) {
    this._inteop = obj;
  }
  T getWrappedInteropObject() {
    return _inteop;
  }
}

