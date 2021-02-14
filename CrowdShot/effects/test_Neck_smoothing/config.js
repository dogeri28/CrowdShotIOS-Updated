function Effect()
{
    this.init = function() {
        Api.meshfxMsg("spawn", 0, 0, "tri.bsm2");
        Api.meshfxMsg("shaderVec4", 0, 0, "0.7 0. 0. 0.");
        Api.showRecordButton();
    };
    this.faceActions = [];
    this.noFaceActions = [];
    this.videoRecordStartActions = [];
    this.videoRecordFinishActions = [];
    this.videoRecordDiscardActions = [];
}

configure(new Effect());