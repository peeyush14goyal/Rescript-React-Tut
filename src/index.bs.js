// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as Counter from "./Counter.bs.js";
import * as ReactDom from "react-dom";

var root = document.querySelector("#root");

if (root == null) {
  console.log("Error: could not find react element");
} else {
  ReactDom.render(React.createElement(Counter.make, {
            initialValue: 0
          }), root);
}

export {
  
}
/* root Not a pure module */
