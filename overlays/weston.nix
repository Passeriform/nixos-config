_: prev: {
  weston = prev.weston.override {
    xwaylandSupport = false;
  };
}
