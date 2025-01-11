//Create image Global Variable for stroring base 64 image/png Data
var image;

//Create Local Variable for Providing Message to Client
var photo_message = document.getElementById("photo_message");

//Access Camera Function
function access_camera()
{
    photo_message.className = "";
    photo_message.innerHTML = "";
    var video = document.getElementById('video');
    var camera = document.getElementById('camera');
    var capture = document.getElementById('capture');
    var canvas = document.getElementById('canvas');
    var constraints = {video: true, audio: false};
    stream = navigator.mediaDevices.getUserMedia(constraints)
    .then(function(stream) 
    {
        video.srcObject = stream;
        video.play();
        camera.setAttribute('style',"display: none");
        capture.setAttribute('style',"display: block;margin: auto;");
        video.setAttribute('width',300);
        video.setAttribute('height',340);
        video.setAttribute('style',"display: block;border: 1px solid black;margin: auto;margin-bottom: 5px;");
        canvas.setAttribute('width',150);
        canvas.setAttribute('height',170);
    })
    .catch(function(err) 
    {
        photo_message.className = "alert alert-danger text center mt-2 mb-2"
        photo_message.innerHTML = "Error is : " + err.message;
        photo_message.focus(); 
    });
}

//Take Photo Function
function take_photo() 
{
    photo_message.className = "";
    photo_message.innerHTML = "";
    var video = document.getElementById('video');
    var photopre = document.getElementById('photopre');
    var capture = document.getElementById('capture');
    var final = document.getElementById('final');
    var canvas = document.getElementById('canvas');
    var context = canvas.getContext('2d');
    context.drawImage(video,0,0,150,170);
    image = canvas.toDataURL('image/png');
    photopre.setAttribute('src', image);
    photopre2.setAttribute('src', image);
    capture.innerHTML = "Take Photo Again";
    final.setAttribute('style',"display: block;margin: auto;");
    document.getElementById("photo").value = document.getElementById("photo").defaultValue;
}

//Final Snap Function
function final_snap() 
{
    photo_message.className = "";
    photo_message.innerHTML = "";
    var final = document.getElementById('final');
    var captured_pic = document.getElementById("captured_pic");
    captured_pic.value = image;
    final.setAttribute('style',"display: none");
    document.getElementById("photo").value = document.getElementById("photo").defaultValue;
    $('#myModal').modal('hide');
}

//Check Photo Function
function check_photo()
{
    photo = document.getElementById('photo');
    var captured_pic = document.getElementById('captured_pic').value;
    if(photo.files.length == 0 && (captured_pic == "" || captured_pic == undefined))
    {
        photo_message.className = "alert alert-danger text center mt-2 mb-2"
        photo_message.innerHTML = "Please Attach or Take a Photo";
        photo_message.focus();
        return false;
    }
};

//Set Photo Preview & Check Photo when Attached by Client
var photopath = function(event)
{
    var photopre = document.getElementById("photopre");
    var photopre2 = document.getElementById("photopre2");
    var filename = document.getElementById("photo").value;
    var dot_index = filename.indexOf(".")
    file_extension = filename.substr(dot_index+1,filename.length);
    var file_size = document.getElementById("photo").files[0].size;
    if(file_extension=="jpg"||file_extension=="png"||file_extension=="jpeg")
    {
        if(file_size<100000)
        {
        	photopre2.src = "../static/images/avatar.gif";
            photopre.src = URL.createObjectURL(event.target.files[0]);
            var final = document.getElementById('final');
            var captured_pic = document.getElementById('captured_pic');
            captured_pic.value = "";
            final.setAttribute('style',"display: none");
        }
        else
        {
            photopre.src = "../static/images/avatar.gif";
            photopre2.src = "../static/images/avatar.gif";
            var captured_pic = document.getElementById('captured_pic');
            captured_pic.value = "";
            var final = document.getElementById('final');
            final.setAttribute('style',"display: none");
            document.getElementById("photo").value = document.getElementById("photo").defaultValue;
            photo_message.className = "alert alert-danger text center mt-2 mb-2"
            photo_message.innerHTML = "Photo Image size should be less than 100 KB";
            photo_message.focus();
        }
    }
    else
    {
        photopre.src = "../static/images/avatar.gif";
        photopre2.src = "../static/images/avatar.gif";
        var captured_pic = document.getElementById('captured_pic');
        captured_pic.value = "";
        var final = document.getElementById('final');
        final.setAttribute('style',"display: none");
        document.getElementById("photo").value = document.getElementById("photo").defaultValue;
        photo_message.className = "alert alert-danger text center mt-2 mb-2"
        photo_message.innerHTML = "Choose Valid Image file Format JPG / JPEG Or PNG";
        photo_message.focus();
    }
}