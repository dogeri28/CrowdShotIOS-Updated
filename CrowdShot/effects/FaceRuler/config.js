function setFaceDistanceData(json) {
    var textInfo = JSON.parse(json);
    var textParam = new Object();

    var textIdx= 0;

    textParam.width = 1024;
    textParam.height = 97;
    textParam.font = "NotoSans-Regular.ttf";
    textParam.text = textInfo.text;

    Api.meshfxMsg("textTexture", 0, textIdx, JSON.stringify(textParam));
    Api.meshfxMsg("shaderVec4", 0, textIdx, textInfo.R + " " + textInfo.G + " " + textInfo.B + " " + textInfo.A);
}

function Effect() {
    var self = this;

    this.init = function() {
        Api.meshfxMsg("shaderVec4", 0, 0, "0 0 0 0");
        Api.meshfxMsg("spawn", 4, 0, "!glfx_FACE");
        Api.meshfxMsg("spawn", 1, 0, "Face_text.bsm2");

        setFaceDistanceData('{"text":"FaceRuler is off","R":0.5,"G":1.0,"B":0.0,"A":0.7}');

        Api.showRecordButton();
    };

    this.restart = function() {
        Api.meshfxReset();
        self.init();
    };

    this.faceActions = [];
    this.noFaceActions = [];

    this.videoRecordStartActions = [];
    this.videoRecordFinishActions = [];
    this.videoRecordDiscardActions = [this.restart];
}

configure(new Effect());

