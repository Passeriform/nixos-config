self: super: {
  weston = super.weston.override {
    xwaylandSupport = false;
  };
}
