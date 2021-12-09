var filesSeq = 1;
var filesChkTotSize = 0;
var filesTotSize = 0;
var fileChkArr;
var replyFile="";

$(document).ready(function() {
    // 파일 첨부 버튼 클릭 시
    $("#btnAttachFile").click(function() {
        $('#files').trigger("click");
    });

    // 파일 첨부 시
    $('#files').change(function() {
        var files = $(this)[0].files;
        var filesSizeChk = false;
        filesChkTotSize = filesTotSize;
        for (var i = 0; i < files.length; i++) {
            var size = files[i].size;
            filesChkTotSize += size;
            if(filesChkTotSize > 21000000) {
                filesSizeChk = true;
                break;
            }
        }
        if (filesSizeChk) {
            alert("파일 첨부 시 최대용량은 21.00MB입니다.");
            return;
        } else {
            fileChkArr = new Array();
            for(var i = 0; i < files.length; i++) {
                var filename = files[i].name;
                var size = files[i].size;
                var fileTag = "<div id='fileBox" + filesSeq + "' class='fileBox'><p>" + filename + "</p>";
                fileTag += "<ul>";
                fileTag += "<li><span class='screen_out'>용량</span>" + formatBytes(size, 2) + "</li>";
                fileTag += "<li><input type='checkbox' id='fileChk" + filesSeq + "' name='fileChk' value=''><label for='fileChk" + filesSeq + "'>선택</label></li>";
                fileTag += "<input type='hidden' id='fileNm" + filesSeq + "' value='' />"
                fileTag += "<input type='hidden' id='filePath" + filesSeq + "' name='filePath' value='' />"
                fileTag += "<input type='hidden' id='fileExt" + filesSeq + "' value='' />"
                fileTag += "<input type='hidden' id='fileSize" + filesSeq + "' value='" + size + "' />"
                fileTag += "</ul>";
                fileTag += "</div>";

                if(i == 0) $("#fileList").show();
                $("#fileList").append(fileTag);

                var fileCount = $("#fileList").find(".fileBox").length;
                filesTotSize += size;
                $("#fileCount").html("<em>" + fileCount + "</em>개 (" + formatBytes(filesTotSize, 2) + " / 21.00 MB)");
                fileChkArr.push(filesSeq);
                filesSeq++;
            }
            // 파일 서브밋
            submitFormFile();
        }
    });

    // 파일 서브밋
    $("#frm_file").submit(function(e) {
        var perc = 0;
        var formData = new FormData();
        if(isEmpty(_param)) _param = -1;
        if(isEmpty(_param2)) _param2 = -1;
        formData.append("wiki_doc_seq", _param);
        var files = $("#files")[0].files;
        for(var i = 0; i < files.length; i++) formData.append("files", files[i]);
        formData.append("fileChkArr", fileChkArr);
        $.ajax({
            url : _context + '/pbbs/insertPbbs5002Wikibbsfle.adm',
            type : 'POST',
            data : formData,
            mimeType :"multipart/form-data",
            contentType : false,
            cache : false,
            processData : false,
            async : true,
            beforeSend : function() {
                $(".files-prog").show();
                $("#file-message").text("파일 업로드중...");
                $("#progBar").width(perc + '%').html(perc + '%');
            },
            xhr : function(){
                var xhr = $.ajaxSettings.xhr() ;
                xhr.upload.onprogress = function(event) {
                    perc = Math.round((event.loaded / event.total) * 100);
                    $("#progBar").width(perc + '%').html(perc + '%');
                    if(perc >= 100) $("#file-message").text("파일 업로드 완료");
                    else $("#file-message").text("파일 업로드중...");
                };
                return xhr ;
            },
            success: function(data) {
                var json = eval('('+data+')');
                if(json.RESULT == _boolean_success) {
                    var fileChkList = json.fileChkList;
                    var fileChkListLen = fileChkList.length;
                    for(var i = 0; i < fileChkListLen; i++) {
                        $("#fileChk"+fileChkList[i].file_id).val(fileChkList[i].file_srl);
                        $("#fileNm"+fileChkList[i].file_id).val(fileChkList[i].file_nm);
                        $("#filePath"+fileChkList[i].file_id).val(fileChkList[i].file_path);
                        $("#fileExt"+fileChkList[i].file_id).val(fileChkList[i].file_ext);
                    }
                }else {
                    alert("정상적으로 실행되지 않았습니다. 잠시후 다시 시도하세요.")
                    return;
                }
            },
            complete : function() {
                $(".files-prog").fadeOut(1500, function() {
                    $("#progBar").width(0 + '%').html(0 + '%');
                });
            }
        });
        e.preventDefault();
    });

    // 본문삽입 버튼 클릭 시
    $("#btnFileAdd").click(function() {
        var chkCnt = $('input[name=fileChk]:checked').length;
        if(chkCnt == 0) {
            alert("선택된 파일이 없습니다.");
            return false;
        }
        if(!confirm("선택한 파일을 본문에 삽입하시겠습니까?")) return false;
        $("input[name=fileChk]:checked").each(function () {
            var file_srl = $(this).val();
            var fileChkId = $(this).attr("id");
            var fileNmId = fileChkId.replace("fileChk", "fileNm");
            var filePathId = fileChkId.replace("fileChk", "filePath");
            var fileExtId = fileChkId.replace("fileChk", "fileExt");
            var fileNm = $("#" + fileNmId).val();
            var filePath = $("#" + filePathId).val();
            var fileExt = $("#" + fileExtId).val().toLowerCase();
            // 1. 이미지
            var innerHtml = "";
            if("jpg" == fileExt || "jpeg" == fileExt || "png" == fileExt || "gif" == fileExt || "bmp" == fileExt) innerHtml = '<img src="' +  filePath + '" alt="' + fileNm + '" /><br />'
            // 2. 이외
            else innerHtml = "<a href='#' onclick='javascript:fileDown(" + file_srl + ");return false;' title='클릭하면 파일이 다운로드됩니다.'>" + fileNm + "</a><br />";
            board_editor.instances['cts'].insertHtml(innerHtml);
        });
    });

    // 선택삭제 버튼 클릭 시
    $("#btnFileDelete").click(function() {
        var chkCnt = $('input[name=fileChk]:checked').length;
        if(chkCnt == 0) {
            alert("선택된 파일이 없습니다.");
            return false;
        }
        if(!confirm("선택한 파일을 삭제하시겠습니까?")) return false;
        $("input[name=fileChk]:checked").each(function () {
            var formData = new FormData();
            var file_srl = $(this).val();
            formData.append("wiki_fl_seq", file_srl);
            var fileChkId = $(this).attr("id");
            $.ajax({
                url : _context + '/pbbs/deletePbbs5002Wikibbsfle.adm',
                type : 'POST',
                data : formData,
                mimeType :"multipart/form-data",
                contentType : false,
                cache : false,
                processData : false,
                async : true,
                success: function(data) {
                    var json = eval('('+data+')');
                    if(json.RESULT == _boolean_success) {
                        var fileBoxId = fileChkId.replace("fileChk", "fileBox");
                        var fileSizeId = fileChkId.replace("fileChk", "fileSize");
                        var size = parseInt($("#" + fileSizeId).val(), 10);
                        $("#"+fileBoxId).remove();
                        var fileCount = $(".fileBox").length;
                        filesTotSize = filesTotSize - size;
                        $("#fileCount").html("<em>" + fileCount + "</em>개 (" + formatBytes(filesTotSize, 2) + " / 21.00 MB)");
                        if(0 == fileCount) $("#fileList").hide();
                        return;
                    }else {
                        alert("정상적으로 실행되지 않았습니다. 잠시후 다시 시도하세요.")
                        return;
                    }
                }
            });
        });
    });
});

//바이트 변환
function formatBytes(bytes, decimals) {
    if(bytes == 0) return '0 Bytes';
    var k = 1024,
        dm = decimals || 2,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = Math.round(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
}

//파일 서브밋
function submitFormFile() {
    $("#frm_file").submit();
}

//파일 다운로드
function fileDown(fl_seq) {
	if(isEmpty(fl_seq)) return false;
	window.open(_context + "/pbbs/filedownloads3.adm?wiki_fl_seq="+fl_seq,"_blank");
}

//확장자 추출
function getExtOfFilename(filename) {
    //빈값이면 추출하지 않음
    if (isEmpty(filename)) return "";
    var _fileLen = filename.length;
    var _lastDot = filename.lastIndexOf('.');
    var _fileExt = filename.substring(_lastDot+1, _fileLen).toLowerCase();

    return _fileExt;
}