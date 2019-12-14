window.addEventListener('DOMContentLoaded', function() {
    document.getElementById("btn-Left").addEventListener("click", rotateCameraLeft);
    document.getElementById("btn-Right").addEventListener("click", rotateCameraRight);

    function rotateCameraLeft(){alert("Rotating camera X° LEFT!");}
    function rotateCameraRight(){alert("Rotating camera X° RIGHT!");}
});