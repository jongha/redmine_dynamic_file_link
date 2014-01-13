$(document).ready(function() {
    var filenames = $(".filename");

    if(filenames.length) {
        var exp = /^http[s]?:\/\/.*\/projects\/.*\/files/gi
        var re = new RegExp(exp);
        var url = document.URL;

        if(re.test(url)) {
            $("<div></div>")
                .html(url + "/[FileName] 으로 링크하시면 같은 이름의 파일 중 최신 파일이 링크됩니다.")
                .css({ padding: "5px 0px" })
                .addClass("warning")
                .insertBefore("table.files")
        }
    }
});