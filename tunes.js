// - <body>
//   - songcont
//     - songlist
//     - status
//       - controls
//       - <p>
//   - filecont
//     - <h1>
//     - <table>

function updateStatus () {
    $.get('status.cgi',
          function (data) {
              $('div#status').html(data);
          });
}

function updatePlaylist () {
    $.get('playlist.cgi',
          function (data) {
              $('div#songlist').html(data);
          });
}

function updateSongs() {
    $.get('songcont.cgi',
          function (data) {
              $('div#songcont').html(data);
          });
}

function control(cmd) {
    $.get('control.cgi?cmd=' + cmd,
          function (data) {
              updateSongs();
          });
}

function navigate(path) {
    var stateObject = { 'path': path };
    $.get('files.cgi?path=' + path,
          function (data) {
              history.replaceState(stateObject, "Music", 'music.cgi?path=' + path);
              $('div#filecont').html(data);
          });
}

function addSong (path, file) {
    $.get('control.cgi?path=' + path + '&cmd=add ' + path + file,
          function (data) {
              updatePlaylist();
          });
}

function addAll (path) {
    $.get('control.cgi?path=' + path + '&cmd=addAll',
          function (data) {
              updatePlaylist();
          });
}

function jumpSong (track) {
    $.get('control.cgi?cmd=jump ' + track,
          function (data) {
              updateSongs();
          });
}

function removeSong (track) {
    $.get('control.cgi?cmd=remove ' + track,
          function (data) {
              updateSongs();
          });
}

function delayedRefresh (seconds) {
    clearTimeout();
    setTimeout(function() { updateSongs(); },
               seconds * 1000);
}
