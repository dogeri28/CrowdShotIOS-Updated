(function (exports) {
  'use strict';

  /**
   * Object.keys {@link https://ponyfoo.com/articles/polyfills-or-ponyfills | ponyfill}
   * @external
   */
  var keys = function (collection) {
      var keys = [];
      for (var key in collection)
          keys.push(key);
      return keys;
  };
  /** High level object API over low level {@link Api.setRecognizerFeatures | Recognizer} API */
  var Recognizer = /*@__PURE__*/ (function () {
      function Recognizer() {
          /** Hash map of enabled features */
          this._enabled = {};
      }
      /** Enables Recognizer feature */
      Recognizer.prototype.enable = function (feature) {
          if (feature in this._enabled)
              return this;
          this._enabled[feature] = true;
          Api.setRecognizerFeatures(keys(this._enabled));
          return this;
      };
      /** Disables Recognizer feature */
      Recognizer.prototype.disable = function (feature) {
          if (!(feature in this._enabled))
              return this;
          Api.setRecognizerFeatures(keys(this._enabled));
          delete this._enabled[feature];
          return this;
      };
      return Recognizer;
  }());
  /** Global Recognizer instance */
  var recognizer = /*@__PURE__*/ new Recognizer();

  /*! *****************************************************************************
  Copyright (c) Microsoft Corporation.

  Permission to use, copy, modify, and/or distribute this software for any
  purpose with or without fee is hereby granted.

  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
  REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
  AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
  INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
  LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
  OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
  PERFORMANCE OF THIS SOFTWARE.
  ***************************************************************************** */
  /* global Reflect, Promise */

  var extendStatics = function(d, b) {
      extendStatics = Object.setPrototypeOf ||
          ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
          function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
      return extendStatics(d, b);
  };

  function __extends(d, b) {
      extendStatics(d, b);
      function __() { this.constructor = d; }
      d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
  }

  function __decorate(decorators, target, key, desc) {
      var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
      if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
      else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
      return c > 3 && r && Object.defineProperty(target, key, r), r;
  }

  /**
   * Classic Nodejs {@link https://medium.com/developers-arena/nodejs-event-emitters-for-beginners-and-for-experts-591e3368fdd2 | Event emitter}
   * @external
   */
  var EventEmitter = /*@__PURE__*/ (function () {
      function EventEmitter() {
          this.__listeners = {};
      }
      /** Adds the listener to the event */
      EventEmitter.prototype.on = function (event, listener) {
          var _a;
          var _b;
          ((_a = (_b = this.__listeners)[event]) !== null && _a !== void 0 ? _a : (_b[event] = [])).push(listener);
          return this;
      };
      /** Removes the listener from the event */
      EventEmitter.prototype.off = function (event, listener) {
          var _a, _b, _c;
          var idx = (_b = (_a = this.__listeners[event]) === null || _a === void 0 ? void 0 : _a.indexOf(listener)) !== null && _b !== void 0 ? _b : -1;
          if (idx !== -1)
              (_c = this.__listeners[event]) === null || _c === void 0 ? void 0 : _c.splice(idx, 1);
          return this;
      };
      /** Invokes the event listeners */
      EventEmitter.prototype.emit = function (event) {
          var _a;
          (_a = this.__listeners[event]) === null || _a === void 0 ? void 0 : _a.forEach(function (listener) { return listener(); });
          return this;
      };
      return EventEmitter;
  }());

  /** Object API for face presence detection */
  var FaceTracker = /*@__PURE__*/ (function (_super) {
      __extends(FaceTracker, _super);
      function FaceTracker() {
          // Backward compatibility
          // will be removed when `scene` is released
          var _this = _super !== null && _super.apply(this, arguments) || this;
          /**
           * Emits "face" event
           *
           * Designed to be used in conjunction with {@link Effect.faceActions} (see example)
           * @deprecated
           * This is a backward-compatibility and is considered for removal in favor of Recognizer from Scene API
           * @example
           * ```ts
           * // config.ts
           *
           * configure({
           *  // ...
           *  faceActions: [FaceTracker.emitFaceDetected],
           *  // ...
           * })
           * ```
           */
          _this.emitFaceDetected = function () { return _this.emit("face"); };
          /**
           * Emits "no-face" event
           *
           * Designed to be used in conjunction with {@link Effect.noFaceActions} (see example)
           * @deprecated
           * This is a backward-compatibility and is considered for removal in favor of Recognizer from Scene API
           * @example
           * ```ts
           * // config.ts
           *
           * configure({
           *  // ...
           *  noFaceActions: [FaceTracker.emitNoFaceDetected],
           *  // ...
           * })
           * ```
           */
          _this.emitNoFaceDetected = function () { return _this.emit("no-face"); };
          return _this;
      }
      return FaceTracker;
  }(EventEmitter));
  /** Global FaceTracker instance */
  var faceTracker = /*@__PURE__*/ new FaceTracker();

  /** High level object API over low level {@link Api.meshfxMsg | Api.meshfxMsg("wlut")} */
  var Lut = /*@__PURE__*/ (function () {
      /**
       * @param index - the index of `glfx_WLUT{0,1,2,3}` defined in shaders
       *
       * e.g.
       * `0` for `glfx_WLUT0`, `1` for `glfx_WLUT1`, etc
       * @param file - filepath of LUT file to use
       * @example
       * ```ts
       * new Lut(mesh, 0, "lut3d_barbie.png")
       * ```
       */
      function Lut(mesh, index, file) {
          var _this = this;
          this._strength = 0;
          /** Used to auto-reload the LUT on mesh enable */
          this._reload = function () {
              if (!_this._file)
                  return;
              Api.meshfxMsg("wlut", _this._index, _this._strength, _this._file);
          };
          this._index = index;
          this._file = file;
          if (mesh["_isEnabled"])
              this._reload();
          mesh.on("enabled", this._reload);
      }
      /** Sets the file as LUT file */
      Lut.prototype.set = function (file) {
          this._file = file;
          Api.meshfxMsg("wlut", this._index, this._strength, this._file);
          return this;
      };
      /** Sets LUT strength from 0 to 1 */
      Lut.prototype.strength = function (value) {
          this._strength = value;
          if (this._file != null) {
              Api.meshfxMsg("wlut", this._index, this._strength * 100, this._file); // 100 - stands for mapping: [0, 1] -> [0, 100]
          }
          return this;
      };
      return Lut;
  }());

  /**
   * Auto-increment {@link Mesh._id} generator
   * @private
   */
  var id = (function () {
      var i = 0;
      return function () { return i++; };
  })();
  /** High level object API over low level {@link Api.meshfxMsg | Api.meshfxMsg("spawn")} */
  var Mesh = /*@__PURE__*/ (function (_super) {
      __extends(Mesh, _super);
      /**
       * @param file - filepath of .bsm2 model to be used of special `"!glfx_FACE"` keyword (see {@link https://docs.banuba.com/docs/effect_constructor/reference/config_js#spawn | the link} for details)
       */
      function Mesh(file) {
          var _this = _super.call(this) || this;
          _this._id = id();
          _this._isEnabled = false;
          _this._file = file;
          return _this;
      }
      /** Shows the mesh and allocates resources */
      Mesh.prototype.enable = function () {
          if (this._isEnabled)
              return this;
          this._isEnabled = true;
          Api.meshfxMsg("spawn", this._id, 0, this._file);
          this.emit("enabled");
          return this;
      };
      /** Hides the mesh and frees resources */
      Mesh.prototype.disable = function () {
          if (!this._isEnabled)
              return this;
          this._isEnabled = false;
          Api.meshfxMsg("del", this._id);
          this.emit("disabled");
          return this;
      };
      return Mesh;
  }(EventEmitter));

  /** High level object API over low level {@link Api.meshfxMsg | Api.meshfxMsg("beautyMorph")} */
  var FaceMorph = /*@__PURE__*/ (function () {
      /**
       * @example
       * ```ts
       * const eyes = new FaceMorph("eyes")
       *  .strength(0.75)
       * ```
       */
      function FaceMorph(property) {
          this._strength = 0;
          this._property = property;
      }
      /** Sets morph strength from 0 to 1 */
      FaceMorph.prototype.strength = function (value) {
          this._strength = value;
          Api.meshfxMsg("beautyMorph", 0, this._strength * 100, this._property); // 100 - stands for mapping: [0, 1] -> [0, 100]
          return this;
      };
      return FaceMorph;
  }());

  /** High level object API over {@link Api.meshfxMsg | Api.meshfxMsg("tex")} */
  var Texture = /*@__PURE__*/ (function () {
      /**
       * @param index - the index of texture sampler defined in cfg.toml (see {@link https://docs.banuba.com/docs/effect_constructor/reference/cfg_toml#materials | the link } for details)
       * @param file - filepath of texture file to use
       * @example
       * ```ts
       * new Texture(mesh, 2, "softlight.ktx")
       * ```
       */
      function Texture(mesh, index, file) {
          var _this = this;
          /** Used to auto-reload the texture on mesh enable */
          this._reload = function () {
              if (!_this._file)
                  return;
              Api.meshfxMsg("tex", _this._mesh["_id"], _this._index, _this._file);
          };
          this._mesh = mesh;
          this._index = index;
          this._file = file;
          if (this._mesh["_isEnabled"])
              this._reload();
          this._mesh.on("enabled", this._reload);
      }
      /** Sets the file as texture file */
      Texture.prototype.set = function (file) {
          this._file = file;
          if (this._mesh["_isEnabled"]) {
              Api.meshfxMsg("tex", this._mesh["_id"], this._index, this._file);
          }
          return this;
      };
      return Texture;
  }());

  /**
   * Internally used by Vec4 to provide the same Vec4 instance for the same GLSL `vec4` index
   * @private
   * @example
   * ```ts
   * new Vec4(42) === new Vec4(42) // true
   * new Vec4(1) === new Vec4(2) // false
   * ```
   */
  var cache = {};
  /**
   * High level object API over {@link Api.meshfxMsg | Api.meshfxMsg("shaderVec4") }
   *
   * Generally it's an object representation of {@link https://thebookofshaders.com/glossary/?search=vec4 | GLSL vec4}
   */
  var Vec4 = /*@__PURE__*/ (function () {
      /**
       * @param index - index of shader `vec4` variable (see {@link https://docs.banuba.com/docs/effect_constructor/reference/config_js#shadervec4 | link} for details)
       *
       * @example
       * ```ts
       * const vec4 = new Vec4(42)
       * ```
       */
      function Vec4(index) {
          this.x = new Component(this);
          this.y = new Component(this);
          this.z = new Component(this);
          this.w = new Component(this);
          this._index = index;
          if (!(index in cache))
              cache[index] = this;
          return cache[index];
      }
      /**
       * Sets `vec4` components at once
       * @example
       * ```ts
       * const vec4 = new Vec4(42).set("1 2 3 4") // "1 2 3 4"
       *
       * vec4.x.get() // 1
       * vec4.y.get() // 2
       * vec4.z.get() // 3
       * vec4.w.get() // 4
       *
       * vec4.set("5 6") // "5 6 0 0"
       *
       * vec4.x.get() // 5
       * vec4.y.get() // 6
       * vec4.z.get() // but `undefined`
       * vec4.w.get() // but `undefined`
       * ```
       */
      Vec4.prototype.set = function (xyzw) {
          var _a = xyzw.split(" ").map(parseFloat), x = _a[0], y = _a[1], z = _a[2], w = _a[3];
          this.x["_value"] = x;
          this.y["_value"] = y;
          this.z["_value"] = z;
          this.w["_value"] = w;
          Api.meshfxMsg("shaderVec4", 0, this._index, this.toString());
          return this;
      };
      /**
       * Returns string representation of {@link Vec4}
       * @example
       * ```ts
       * new Vec4(42).set("1 2 3 4").toString() // "1 2 3 4"
       * ```
       */
      Vec4.prototype.toString = function () {
          return [
              this.x.toString(),
              this.y.toString(),
              this.z.toString(),
              this.w.toString(),
          ].join(" ");
      };
      return Vec4;
  }());
  /**
   * Object representation of {@link https://thebookofshaders.com/glossary/?search=vec4 | GLSL vec4} component (coordinate)
   *
   * Simplifies sync & manipulation of `vec4` components (coordinates)
   *
   * @private
   * @typeParam T - Type of component value.
   *
   * It may be useful to force the component to be treated as `Component<number>` to avoid type warnings, e.g:
   * ```ts
   * const x = new Vec4(1).x
   * x.set(x => x + 1) // Warning: Operator '+' cannot be applied to types 'number | boolean' and 'number'.
   *
   * const y = new Vec4(2).y
   * y.set(y => <number>y + 1) // it's ok but verbose

   * const z = new Vec4(3).z as Coordinate<number>
   * z.set(z => z + 1) // it's just fine
   * ```
   * @example
   * ```ts
   * const vec4 = new Vec4(42) // "0 0 0 0"
   *
   * vec4.y.set(2) // same as vec4.set("0 2 0 0")
   * vec4.z.set(3) // same as vec4.set("0 2 3 0")
   *
   * vec4.w.set(w => <number>w + 4) // same as vec4.set("0 2 3 4")
   * ```
   */
  var Component = /*@__PURE__*/ (function () {
      function Component(parent) {
          this._parent = parent;
      }
      /** Returns the component value */
      Component.prototype.get = function () { return this._value; };
      Component.prototype.set = function (value) {
          if (typeof value === "function")
              value = value(this._value);
          this._value = value;
          Api.meshfxMsg("shaderVec4", 0, this._parent["_index"], this._parent.toString());
          return this;
      };
      /**
       * Returns string representation of the {@link Component} according to the following rules:
       *
       * - for {@link https://developer.mozilla.org/en-US/docs/Glossary/Falsy | falsy} values returns `"0"`
       * - for {@link https://developer.mozilla.org/en-US/docs/Glossary/Truthy | truthy } values returns string representation of the value number representation
       * @example
       * ```ts
       * new vec4 = new Vex4(42)
       * vec4.x.get() // `undefined`
       * vec4.x.toString() // "0"
       *
       * vec4.x.set(false).get() // false
       * vec.x.toString() // "0"
       *
       * vec4.x.set(true).get() // true
       * vec4.x.toString() // "1"
       *
       * vec4.x.set(42).get() // 42
       * vec4.x.toString() // "42"
       * ```
       */
      Component.prototype.toString = function () {
          var value = this._value;
          if (!value)
              value = Boolean(value);
          if (typeof value === "boolean")
              value = Number(value);
          if (typeof value === "number")
              value = String(value);
          return value;
      };
      return Component;
  }());

  function json(target, key, desc) {
      if (arguments.length === 3) {
          var method_1 = target[key];
          if (typeof method_1 !== "function")
              return;
          desc.value = function (maybeJson) {
              if (typeof maybeJson === "string") {
                  try {
                      maybeJson = JSON.parse(maybeJson);
                  }
                  catch (_a) { }
              }
              return method_1.call(this, maybeJson);
          };
      }
      for (var method in target.prototype) {
          json(target.prototype, method, Object.getOwnPropertyDescriptor(target.prototype, method));
      }
  }

  var FaceMorph$1 = /*@__PURE__*/ (function () {
      function FaceMorph$1() {
          this.morphs = {
              face: new FaceMorph("face"),
              eyes: new FaceMorph("eyes"),
              nose: new FaceMorph("nose"),
          };
      }
      /** Sets face (cheeks) shrink strength from 0 to 1 */
      FaceMorph$1.prototype.face = function (strength) {
          this.morphs.face.strength(strength);
          return this;
      };
      /** Sets eyes grow strength from 0 to 1 */
      FaceMorph$1.prototype.eyes = function (strength) {
          this.morphs.eyes.strength(2 * strength); // TODO: What "2" stands for
          return this;
      };
      /** Sets nose shrink strength from 0 to 1 */
      FaceMorph$1.prototype.nose = function (strength) {
          this.morphs.nose.strength(strength);
          return this;
      };
      __decorate([
          json
      ], FaceMorph$1.prototype, "face", null);
      __decorate([
          json
      ], FaceMorph$1.prototype, "eyes", null);
      __decorate([
          json
      ], FaceMorph$1.prototype, "nose", null);
      return FaceMorph$1;
  }());
  /** Global FaceMorph instance */
  var faceMorph = /*@__PURE__*/ new FaceMorph$1();

  /**
   * Converts a given string to {@link Vec4.toString | Vec4 string}
   *
   * @external
   * @example
   * ```
   * toVec4String("") // "0 0 0 1"
   * toVec4String("1") // "1 0 0 1"
   * toVec4String("1 2") // "1 2 0 1"
   * toVec4String("1 2 3") // "1 2 3 1"
   * toVec4String("1 2 3 4") // "1 2 3 4"
   * ```
   */
  var toVec4String = function (value) {
      var _a = value.split(" "), _b = _a[0], r = _b === void 0 ? 0 : _b, _c = _a[1], g = _c === void 0 ? 0 : _c, _d = _a[2], b = _d === void 0 ? 0 : _d, _e = _a[3], a = _e === void 0 ? 1 : _e;
      return [r, g, b, a].join(" ");
  };
  /**
   * @external
   * @alias {@link toVec4String}
   */
  var rgba = toVec4String;

  var mesh = "skin.bsm2";

  var js_skin_color = 16;

  /**
   * Colors skin with a color
   */
  var Skin = /*@__PURE__*/ (function () {
      function Skin() {
          this._mesh = new Mesh(mesh)
              .on("enabled", function () { return recognizer.enable("skin_segmentation"); })
              .on("disabled", function () { return recognizer.disable("skin_segmentation"); });
          this._color = new Vec4(js_skin_color);
      }
      /** Sets skin color */
      Skin.prototype.color = function (color) {
          this._mesh.enable();
          this._color.set(rgba(color));
          return this;
      };
      Skin.prototype.clear = function () {
          this._color.set("0 0 0 0");
          this._mesh.disable();
          return this;
      };
      __decorate([
          json
      ], Skin.prototype, "color", null);
      return Skin;
  }());
  /** Global Skin instance */
  var skin = /*@__PURE__*/ new Skin();

  var defaultMakeupTexture = "MakeupNull.png";

  var defaultSoftlightTexture = "soft.ktx";

  var defaultTeethLut = "lut3d_teeth_highlighter5.png";

  var defaultFlareTexture = "FLARE_38_512.png";

  var defaultEyesLut = "lut3d_eyes_verylow.png";

  var js_softlight = 0;
  var js_skinsoftening_removebags_rotation = 1;
  var js_is_apply_makeup = 2;

  /**
   * Global Retouch instance
   * @hidden
   */
  var Retouch = /*@__PURE__*/ (function () {
      var m = new Mesh("!glfx_FACE")
          .on("enabled", function () {
          // the "z" aka "rotation" has to be set to 1 cuz otherwise nether skinsoftening nor softlight will work
          new Vec4(js_skinsoftening_removebags_rotation).z.set(1);
      });
      /** These textures have to be set simultaniously cuz otherwise Retouch wont be rendered */
      var textures = {
          soflight: new Texture(m, 0, defaultSoftlightTexture),
          makeup: new Texture(m, 1, defaultMakeupTexture),
          eyesflare: new Texture(m, 2, defaultFlareTexture),
      };
      /** These luts have to be set simultaneously cuz otherwise face will have highlighted eyes and teeth */
      var luts = {
          eyes: new Lut(m, 1, defaultEyesLut),
          teeth: new Lut(m, 2, defaultTeethLut),
      };
      return {
          enable: m.enable.bind(m),
          textures: textures,
          luts: luts,
      };
  })();
  /** Highlights a face like a directional flash light */
  var Softlight = /*@__PURE__*/ (function () {
      function Softlight() {
          this._isEnabled = new Vec4(js_is_apply_makeup).y;
          this._strength = new Vec4(js_softlight).y;
      }
      /** Sets highlight strength from 0 to 1 */
      Softlight.prototype.strength = function (value) {
          Retouch.enable();
          this._strength.set(value);
          this._isEnabled.set(value !== 0);
          return this;
      };
      __decorate([
          json
      ], Softlight.prototype, "strength", null);
      return Softlight;
  }());
  /** Softs (smooths) a face skin */
  var SkinSoftening = /*@__PURE__*/ (function () {
      function SkinSoftening() {
          this._strength = new Vec4(js_skinsoftening_removebags_rotation).x;
      }
      /** Sets skin softening strength from 0 to 1 */
      SkinSoftening.prototype.strength = function (value) {
          Retouch.enable();
          this._strength.set(value);
          return this;
      };
      __decorate([
          json
      ], SkinSoftening.prototype, "strength", null);
      return SkinSoftening;
  }());
  /** Whitens teeth */
  var TeethWhitening = /*@__PURE__*/ (function () {
      function TeethWhitening() {
          this._lut = Retouch.luts.teeth;
      }
      /** Sets teeth whitening strength from 0 to 1 */
      TeethWhitening.prototype.strength = function (value) {
          Retouch.enable();
          this._lut.strength(value);
          return this;
      };
      __decorate([
          json
      ], TeethWhitening.prototype, "strength", null);
      return TeethWhitening;
  }());
  /** Global Softlight instance */
  var softlight = /*@__PURE__*/ new Softlight();
  /** Global SkinSoftening instance */
  var skinSoftening = /*@__PURE__*/ new SkinSoftening();
  /** Global TeethWhitening instance */
  var teethWhitening = /*@__PURE__*/ new TeethWhitening();

  var mesh$1 = "make01.bsm2";

  var defaultContourTexture = "contour.png";

  var defaultBlusherTexture = "blushes.png";

  var defaultEyeshadowTexture = "eyeshadow.png";

  var defaultEyelinerTexture = "eyeliner.png";

  var defaultLashesTexture = "eyelashes.png";

  var defaultBrowsTexture = "eyebrows.png";

  var defaultHighlighterTexture = "highlighter.png";

  var js_blushes_color = 4;
  var js_contour_color = 5;
  var js_eyeliner_color = 6;
  var js_eyeshadow_color = 7;
  var js_lashes_color = 8;
  var js_brows_color = 9;
  var js_highlighter_color = 10;

  /** @hidden */
  var Makeup = /*@__PURE__*/ (function () {
      var m = new Mesh(mesh$1)
          .on("enabled", function () { return Retouch.enable(); });
      /** These textures have to be set cuz otherwise Makeup wont be rendered */
      var textures = {
          blusher: new Texture(m, 0, defaultBlusherTexture),
          contouring: new Texture(m, 1, defaultContourTexture),
          eyeliner: new Texture(m, 2, defaultEyelinerTexture),
          eyeshadow: new Texture(m, 3, defaultEyeshadowTexture),
          lashes: new Texture(m, 4, defaultLashesTexture),
          brows: new Texture(m, 5, defaultBrowsTexture),
          highlighter: new Texture(m, 6, defaultHighlighterTexture),
          __reserved: new Texture(m, 7, defaultMakeupTexture),
      };
      return {
          enable: m.enable.bind(m),
          textures: textures,
      };
  })();
  /** Represents particular facial area like contouring, blushes, etc */
  var FacialArea = /*@__PURE__*/ (function () {
      function FacialArea(texture, color) {
          this._texture = texture;
          this._color = color;
          Makeup.enable();
      }
      /** Sets the facial area texture */
      FacialArea.prototype.set = function (texture) {
          this._texture.set(texture);
          return this;
      };
      /** Sets the facial area color */
      FacialArea.prototype.color = function (color) {
          this._color.set(rgba(color));
          return this;
      };
      /** Resets the facial area color */
      FacialArea.prototype.clear = function () {
          this._color.set("0 0 0 0");
          return this;
      };
      __decorate([
          json
      ], FacialArea.prototype, "set", null);
      __decorate([
          json
      ], FacialArea.prototype, "color", null);
      return FacialArea;
  }());
  var Contour = /*@__PURE__*/ (function (_super) {
      __extends(Contour, _super);
      function Contour() {
          return _super.call(this, Makeup.textures.contouring, new Vec4(js_contour_color)) || this;
      }
      return Contour;
  }(FacialArea));
  var Blush = /*@__PURE__*/ (function (_super) {
      __extends(Blush, _super);
      function Blush() {
          return _super.call(this, Makeup.textures.blusher, new Vec4(js_blushes_color)) || this;
      }
      return Blush;
  }(FacialArea));
  var Eyeshadow = /*@__PURE__*/ (function (_super) {
      __extends(Eyeshadow, _super);
      function Eyeshadow() {
          return _super.call(this, Makeup.textures.eyeshadow, new Vec4(js_eyeshadow_color)) || this;
      }
      return Eyeshadow;
  }(FacialArea));
  var Eyeliner = /*@__PURE__*/ (function (_super) {
      __extends(Eyeliner, _super);
      function Eyeliner() {
          return _super.call(this, Makeup.textures.eyeliner, new Vec4(js_eyeliner_color)) || this;
      }
      return Eyeliner;
  }(FacialArea));
  var Eyelashes = /*@__PURE__*/ (function (_super) {
      __extends(Eyelashes, _super);
      function Eyelashes() {
          return _super.call(this, Makeup.textures.lashes, new Vec4(js_lashes_color)) || this;
      }
      return Eyelashes;
  }(FacialArea));
  var Eyebrows = /*@__PURE__*/ (function (_super) {
      __extends(Eyebrows, _super);
      function Eyebrows() {
          return _super.call(this, Makeup.textures.brows, new Vec4(js_brows_color)) || this;
      }
      return Eyebrows;
  }(FacialArea));
  var Highlighter = /*@__PURE__*/ (function (_super) {
      __extends(Highlighter, _super);
      function Highlighter() {
          return _super.call(this, Makeup.textures.highlighter, new Vec4(js_highlighter_color)) || this;
      }
      return Highlighter;
  }(FacialArea));
  /** Global Contour instance */
  var contour = /*@__PURE__*/ new Contour();
  /** Global Blush instance */
  var blush = /*@__PURE__*/ new Blush();
  /** Global Eyeshadow instance */
  var eyeshadow = /*@__PURE__*/ new Eyeshadow();
  /** Global Eyeliner instance */
  var eyeliner = /*@__PURE__*/ new Eyeliner();
  /** Global Eyelashes instance */
  var eyelashes = /*@__PURE__*/ new Eyelashes();
  /** Global Eyebrows instance */
  var eyebrows = /*@__PURE__*/ new Eyebrows();
  /** Global Highlighter instance */
  var highlighter = /*@__PURE__*/ new Highlighter();

  var mesh$2 = "lips.bsm2";

  var js_lips_color = 32;
  var js_lips_brightness_contrast = 33;

  /** Colors lips with mat color, adjusts brightness and contrast of the color */
  var Lips = /*@__PURE__*/ (function () {
      function Lips() {
          this._mesh = new Mesh(mesh$2)
              .on("enabled", function () { return recognizer.enable("lips_segmentation"); })
              .on("disabled", function () { return recognizer.disable("lips_segmentation"); });
          this._color = new Vec4(js_lips_color);
          /**
           * Dull is opposite of saturation
           *
           * Changing saturation from 0 to 1 means from less saturated to more saturated
           * Changing dull from 0 to 1 means from more saturated to less saturated
           */
          this._dull = new Vec4(js_lips_brightness_contrast).x.set(0); // x actually changes saturation
          this._brightness = new Vec4(js_lips_brightness_contrast).y.set(1); // y actually changes brightness
      }
      /** Sets lips colors */
      Lips.prototype.color = function (color) {
          this._mesh.enable();
          this._color.set(rgba(color));
          return this;
      };
      /** Sets the lips color saturation */
      Lips.prototype.saturation = function (value) {
          this._dull.set(1 - value);
          return this;
      };
      /** Sets the lips color brightness */
      Lips.prototype.brightness = function (value) {
          this._brightness.set(value);
          return this;
      };
      /** Resets lips color, brightness and contrast */
      Lips.prototype.clear = function () {
          this._color.set("0 0 0 0");
          this._dull.set(0);
          this._brightness.set(1);
          this._mesh.disable();
          return this;
      };
      __decorate([
          json
      ], Lips.prototype, "color", null);
      __decorate([
          json
      ], Lips.prototype, "saturation", null);
      __decorate([
          json
      ], Lips.prototype, "brightness", null);
      return Lips;
  }());
  /** Global Lips instance */
  var lips = /*@__PURE__*/ new Lips();

  var mesh$3 = "eyes.bsm2";

  var js_is_face_tracked = 11;
  var js_eyes_color = 17;

  /** Sets eyes color */
  var EyesColor = /*@__PURE__*/ (function () {
      function EyesColor() {
          var _this = this;
          this._mesh = new Mesh(mesh$3)
              .on("enabled", function () {
              recognizer.enable("eyes_segmentation");
              faceTracker // TODO: The `eyes` works bad without face tracker, but `lips` and `lips_shiny` are okay ¯\_(ツ)_/¯
                  .on("face", _this._enable)
                  .on("no-face", _this._disable);
          })
              .on("disabled", function () {
              recognizer.disable("eyes_segmentation");
              faceTracker
                  .off("face", _this._enable)
                  .off("no-face", _this._disable);
          });
          this._isEnabled = new Vec4(js_is_face_tracked).x;
          this._color = new Vec4(js_eyes_color);
          this._enable = function () { return _this._isEnabled.set(true); };
          this._disable = function () { return _this._isEnabled.set(false); };
      }
      /** Sets eyes color */
      EyesColor.prototype.color = function (color) {
          this._mesh.enable();
          this._color.set(rgba(color));
          return this;
      };
      /** Resets eyes color */
      EyesColor.prototype.clear = function () {
          this._color.set("0 0 0 0");
          this._mesh.disable();
          return this;
      };
      __decorate([
          json
      ], EyesColor.prototype, "color", null);
      return EyesColor;
  }());
  /** Global EyesColor instance */
  var eyesColor = /*@__PURE__*/ new EyesColor();

  var mesh$4 = "shiny_lips.bsm2";

  var js_lips_color$1 = 32;
  var lips_params = 34;

  var defaultParams = "1.5 1 0.5 1";
  /** Colors lips with shiny color, adjusts brightness and contrast of the color*/
  var ShinyLips = /*@__PURE__*/ (function () {
      function ShinyLips() {
          this._mesh = new Mesh(mesh$4)
              .on("enabled", function () { return recognizer.enable("lips_shine"); })
              .on("disabled", function () { return recognizer.disable("lips_shine"); });
          this._color = new Vec4(js_lips_color$1);
          /**
           * @property params.x - sCoef -- color saturation
           * @property params.y - vCoef -- shine brightness (intensity)
           * @property params.z - sCoef1 -- shine saturation (color bleeding)
           * @property params.w - bCoef -- darkness (more is less)
           */
          this._params = new Vec4(lips_params).set(defaultParams);
      }
      /** Sets lips color */
      ShinyLips.prototype.color = function (color) {
          this._mesh.enable();
          this._color.set(rgba(color));
          return this;
      };
      /** Sets the color saturation  */
      ShinyLips.prototype.saturation = function (value) {
          this._params.x.set(value);
          return this;
      };
      /** Sets the color brightness */
      ShinyLips.prototype.brightness = function (value) {
          this._params.w.set(value);
          return this;
      };
      /** Sets the lips shine intensity */
      ShinyLips.prototype.shineIntensity = function (value) {
          this._params.y.set(value);
          return this;
      };
      /** Sets the lips shine blending */
      ShinyLips.prototype.shineBlending = function (value) {
          this._params.z.set(value);
          return this;
      };
      /** Resets lips color */
      ShinyLips.prototype.clear = function () {
          this._color.set("0 0 0 0");
          this._params.set(defaultParams);
          this._mesh.disable();
          return this;
      };
      __decorate([
          json
      ], ShinyLips.prototype, "color", null);
      __decorate([
          json
      ], ShinyLips.prototype, "saturation", null);
      __decorate([
          json
      ], ShinyLips.prototype, "brightness", null);
      __decorate([
          json
      ], ShinyLips.prototype, "shineIntensity", null);
      __decorate([
          json
      ], ShinyLips.prototype, "shineBlending", null);
      return ShinyLips;
  }());
  /** Global ShinyLips instance */
  var shinyLips = /*@__PURE__*/ new ShinyLips();

  /**
   * @packageDocumentation
   * @module Beauty/features/foundation
   * @external
   */
  var Foundation = /*@__PURE__*/ (function () {
      function Foundation() {
      }
      /** Sets foundation color */
      Foundation.prototype.color = function (color) {
          skin.color(color);
          return this;
      };
      /** Sets foundation cover strength from 0 to 1 */
      Foundation.prototype.strength = function (value) {
          skinSoftening.strength(value);
          return this;
      };
      /** Resets foundation */
      Foundation.prototype.clear = function () {
          skin.clear();
          skinSoftening.strength(0);
          return this;
      };
      return Foundation;
  }());
  /** Global Foundation instance */
  var foundation = new Foundation();

  /**
   * @packageDocumentation
   * @module Beauty/features/lips
   * @external
   */
  var Lips$1 = /*@__PURE__*/ (function () {
      function Lips() {
          this._lips = lips;
          this._color = "0 0 0 0";
          this._saturation = 1;
          this._brightness = 1;
          this._shine = {
              get isActive() { return this.intensity != 0 || this.blending != 0; },
              intensity: this._lips === lips ? 0 : 1,
              blending: this._lips === lips ? 0 : 0.5,
          };
      }
      Lips.prototype._useLips = function (lips) {
          // switch lips if needed
          if (this._lips === lips)
              return this._lips;
          this._lips.clear();
          this._lips = lips;
          // restore common properties
          this._lips
              .color(this._color)
              .saturation(this._saturation)
              .brightness(this._brightness);
          return this._lips;
      };
      Lips.prototype.color = function (color) {
          this._color = color;
          this._lips.color(this._color);
          return this;
      };
      Lips.prototype.saturation = function (value) {
          this._saturation = value;
          this._lips.saturation(this._saturation);
          return this;
      };
      Lips.prototype.brightness = function (value) {
          this._brightness = value;
          this._lips.brightness(this._brightness);
          return this;
      };
      Lips.prototype.shineIntensity = function (value) {
          this._shine.intensity = value;
          if (this._shine.isActive) {
              this
                  ._useLips(shinyLips)
                  .shineIntensity(this._shine.intensity);
          }
          else {
              this
                  ._useLips(lips);
          }
          return this;
      };
      Lips.prototype.shineBlending = function (value) {
          this._shine.blending = value;
          if (this._shine.isActive) {
              this
                  ._useLips(shinyLips)
                  .shineBlending(this._shine.blending);
          }
          else {
              this
                  ._useLips(lips);
          }
          return this;
      };
      /**
       * Sets matt lips color
       * This is a helper method equivalent of `Lips.color(rgba).saturation(1).shineIntensity(0).shineBlending(0)`
       */
      Lips.prototype.matt = function (color) {
          return this
              .color(color)
              .saturation(1)
              .shineIntensity(0)
              .shineBlending(0);
      };
      /**
       * Sets shiny lips color
       * This is a helper method equivalent of `Lips.color(rgba).saturation(1.5).shineIntensity(1).shineBlending(0.5)`
       */
      Lips.prototype.shiny = function (color) {
          return this
              .color(color)
              .saturation(1.5)
              .shineIntensity(1)
              .shineBlending(0.5);
      };
      /** Resets lips color */
      Lips.prototype.clear = function () {
          this._lips.clear();
          this._color = "0 0 0 0";
          this._saturation = 1;
          this._brightness = 1;
          this._shine.intensity = 0;
          this._shine.blending = 0;
          return this;
      };
      return Lips;
  }());
  /** Global Lips instance */
  var lips$1 = new Lips$1();

  var version = "0.32.0";

  /**
   * Effect for virtual Beautification try on
   * @packageDocumentation
   * @module Beauty
   * @external
   */
  configure({
      faceActions: [faceTracker.emitFaceDetected],
      noFaceActions: [faceTracker.emitNoFaceDetected],
      videoRecordStartActions: [],
      videoRecordFinishActions: [],
      videoRecordDiscardActions: [],
      init: function () {
      },
      restart: function () {
          Api.meshfxReset();
          this.init();
      },
  });
  var printVersion = function () { return Api.print("Makeup effect v" + version); };
  /**
   * The effect test function
   * @hidden
   * @example
   * Web:
   * ```js
   * player.callJsMethod("test")
   * ```
   **/
  //@ts-ignore
  function test() {
      faceMorph.eyes(1).nose(1).face(1);
      softlight.strength(1);
      teethWhitening.strength(1);
      eyeliner.color("0 0 0");
      eyelashes.color("0 0 0.2");
      eyeshadow.color("0.6 0.5 1 0.6");
      eyebrows.color("0.8 0.4 0.2 0.4");
      eyesColor.color("0 0.2 0.8 0.64");
      foundation.color("0.73 0.39 0.08 0.4").strength(0.75);
      contour.color("0.3 0.1 0.1 0.6");
      highlighter.color("0.75 0.74 0.74 0.4");
      blush.color("0.7 0.1 0.2 0.5");
      lips$1.matt("0.85 0.43 0.5 0.8");
  }

  exports.Blush = blush;
  exports.Contour = contour;
  exports.Eyebrows = eyebrows;
  exports.Eyelashes = eyelashes;
  exports.Eyeliner = eyeliner;
  exports.EyesColor = eyesColor;
  exports.Eyeshadow = eyeshadow;
  exports.FaceMorph = faceMorph;
  exports.Foundation = foundation;
  exports.Highlighter = highlighter;
  exports.Lips = lips$1;
  exports.TeethWhitening = teethWhitening;
  exports.VERSION = version;
  exports.printVersion = printVersion;
  exports.test = test;

  Object.defineProperty(exports, '__esModule', { value: true });


      var globalThis = new Function("return this;")();
      
      for (var key in exports) { globalThis[key] = exports[key]; }
      
      // bugfix: SDK's `callJsMethod` can not call nested (e.b. `foo.bar()`) methods
      for (var key in exports) {
        var value = exports[key];
      
        if (value === null) continue;
        if (typeof value !== "object") continue;
      
        for (var method in Object.getPrototypeOf(value)) {
            var fn = value[method];
            globalThis[key + "." + method] = fn.bind(value);
        }
      }
      

  return exports;

}({}));
/* Feel free to add your custom code below */
function setColor(json) {
    var rgba = JSON.parse(json)
    var color = rgba.join(" ")
   
    Lips.color(color)
   }
   
   function setParams(json) {
    var params = JSON.parse(json)
    var saturation = params[0]
    var shineIntensity = params[1]
    var shineBlending = params[2]
    var brightness = params[3]
   
    Lips
      .saturation(saturation)
      .shineIntensity(shineIntensity)
      .shineBlending(shineBlending)
      .brightness(brightness)
   }