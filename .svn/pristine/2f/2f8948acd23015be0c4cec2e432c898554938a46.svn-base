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
        for(var i = 0; i < files.length; i++) {
            var size = files[i].size;
            filesChkTotSize += size;
            if(filesChkTotSize > 21000000) {
                filesSizeChk = true;
                break;
            }
        }
        filesSizeChk = false;
        if(filesSizeChk) {
            alert("파일 첨부 시 최대용량은 21.00MB입니다.");
            return;
        }else {
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
    	formData.append("doc_seq", _param2);
    	formData.append("modl_seq", _param);
    	formData.append("upl_trg_tp", replyFile);
    	var files = $("#files")[0].files;
    	for(var i = 0; i < files.length; i++) formData.append("files", files[i]);
        formData.append("fileChkArr", fileChkArr);
        $.ajax({
            url : _context + '/pbbs/insertTbbsFlInf.adm',
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
            formData.append("fl_seq", file_srl);
            var fileChkId = $(this).attr("id");
        	$.ajax({
                url : _context + '/pbbs/deleteTbbsFlInf.adm',
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

// 바이트 변환
function formatBytes(bytes, decimals) {
    if(bytes == 0) return '0 Bytes';
    var k = 1024,
        dm = decimals || 2,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = Math.round(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
}

// 파일 서브밋
function submitFormFile() {
	$("#frm_file").submit();
}

// 엑셀 업로드
function uploadExcel(fileId, grdId, errExclTitle, exclHeader, validJsonStr) {
	if(isEmpty(fileId)) {
		console.log("파일 ID 미입력 오류");
		return;
	}
	if(isEmpty(grdId)) {
		console.log("그리드 ID 미입력 오류");
		return;
	}
	if(!confirm("선택한 엑셀 내용을 업로드 하시겠습니까?")) return false;

	// 그리드 초기화
	$("#"+grdId).jqGrid('clearGridData', true);
	$("#"+grdId).jqGrid('setGridParam', {lastrowid:0, lastcolidx:0});

	// 1. 파일
	var files = $("#"+fileId)[0].files;
	var formData = new FormData();
	formData.append("file", files[0]);
	// 2. 그리드 헤더 정보
   	var headerJsonStr = '{';
   	var colCount = 0;
   	var cols = $('#'+grdId).getGridParam().colModel;
   	for(var i = 0; i < cols.length; i++) {
   		if(cols[i].name == 'rn' || cols[i].name == 'cb' || cols[i].label == undefined) {
			continue;
		}

   		if(cols[i].hidden == false) {
	   		if(colCount != 0) {
	   			headerJsonStr = headerJsonStr + ',';
	   		}
	   		colCount++;
   			headerJsonStr = headerJsonStr + '"' + cols[i].name + '":"' + (cols[i].label == undefined ? cols[i].name : cols[i].label) + '"';
   		}
	}
	headerJsonStr = headerJsonStr + '}';
	formData.append("JQGRIDHEADER", headerJsonStr);
	// 3. 엑셀업로드할 헤더 정보
	if(!isEmpty(exclHeader)) {
		headerJsonStr = '{';
		colCount = 0;
		for(var i = 0; i < cols.length; i++) {
			if(cols[i].name == 'rn' || cols[i].name == 'cb' || cols[i].label == undefined) {
				continue;
			}
			for(var j = 0; j < exclHeader.length; j++) {
				if(cols[i].name == exclHeader[j]) {
					if(colCount != 0) {
			   			headerJsonStr = headerJsonStr + ',';
			   		}
			   		colCount++;
					headerJsonStr = headerJsonStr + '"' + cols[i].name + '":"' + (cols[i].label == undefined ? cols[i].name : cols[i].label) + '"';
					break;
				}
			}
		}
		headerJsonStr = headerJsonStr + '}';
	}
	formData.append("UPLOADHEADER", headerJsonStr);
	// 4. 유효성 체크 정보
	formData.append("REQUIRED", headerJsonStr);

	$.ajax({
        url         : _context + '/main/newUploadExcel.adm',
        type        : 'POST',
        data        : formData,
        mimeType    : "multipart/form-data",
        contentType : false,
        cache       : false,
        processData : false,
        async       : true,
        success     : function(data) {
            var json = eval('('+data+')');
            if(json.RESULT == _boolean_success) {
            	if(json.VALID_FILE_YN == _boolean_success) {
            		var sccListCnt = json.records;
            		var errList = json.errRows;
    				var errListCnt = errList.length;
    				if(sccListCnt == 0 && errListCnt == 0) {
    					alert("엑셀 업로드할 데이터가 존재하지 않습니다.");
	            	}else {
	            		// 1. 파일 업로드에 성공한 데이터 그리드에 로드
	            		if(sccListCnt > 0) $("#"+grdId)[0].addJSONData(json);

	                	// 2. 파일 업로드에 실패한 데이터 처리
	    				if(errListCnt > 0) {
	    					var errConfMsg = "엑셀 업로드 데이터 중 유효하지 않은 건들이 존재합니다.";
	    					errConfMsg += "\n\n√. 총 오류건 : " + json.errRowsCnt + "건";
	    					var errCnt_01 = json.errCnt_01;
	    					var errCnt_02 = json.errCnt_02;
	    					var errCnt_03 = json.errCnt_03;
	    					var errCnt_04 = json.errCnt_04;
	    					// 오류건수 : 업로드할 컬럼수 초과 오류
	    					if(errCnt_01 > 0) {
	    						errConfMsg += "\n-. 업로드할 컬럼수 초과 오류 : " + errCnt_01 + "건";
	    					}
	    					// 오류건수 : 필수값 오류
	    					if(errCnt_02 > 0) {
	    						errConfMsg += "\n-. 필수값 오류 : " + errCnt_02 + "건";
	    					}
	    					// 오류건수 : 중복 오류
	    					if(errCnt_03 > 0) {
	    						errConfMsg += "\n-. 중복 오류 : " + errCnt_03 + "건";
	    					}
	    					// 오류건수 : 데이터 미입력 오류
	    					if(errCnt_04 > 0) {
	    						errConfMsg += "\n-. 데이터 미입력 오류 : " + errCnt_04 + "건";
	    					}
	    					errConfMsg += "\n\n해당 건들을 다운로드하시겠습니까?";
	    					if(!confirm(errConfMsg)) return false;

	    					var errRowArr = new Array();
	    					var errMsgArr = new Array();
	    					var errValArr = new Array();
	    					for(var i = 0; i < errListCnt; i++) {
	    						errRowArr[i] = errList[i].err_row;
	    						errMsgArr[i] = errList[i].err_msg;
	    						errValArr[i] = errList[i].err_val;
	    					}

	    					// 파라미터 셋팅
	    					var params ={};
	    					// 1. 그리드 헤더
	    					params.JQGRIDHEADER = headerJsonStr;
	    					// 2. 에러 ROW 정보
	    					params.errRowArr = errRowArr;
	    					params.errMsgArr = errMsgArr;
	    					params.errValArr = errValArr;
	    					var exclTitle = "엑셀업로드 오류 목록";
	    					if(!isEmpty(errExclTitle)) exclTitle = errExclTitle;
	    					params.filename = exclTitle;
	    					// 3. 파일다운로드
	    					fileDownFormSubmit({
	    						url        : '/main/downloadErrExcelList.adm',
	    						params     : params
	    					});
	    				}else {
	    					alert("정상적으로 처리되었습니다.");
	    				}
	            	}
            	}else {
            		alert("엑셀 파일만 업로드할 수 있습니다.");
            	}
            	return;
            }else {
                alert("정상적으로 실행되지 않았습니다. 잠시후 다시 시도하세요.");
                return;
            }
        }
    });
}

// 엑셀양식 다운로드
function downloadExcelForm(grdId, dwExclTitle, exclHeader) {
	if(isEmpty(grdId)) {
		console.log("그리드 ID 미입력 오류");
		return;
	}
	if(!confirm("엑셀양식을 다운로드 하시겠습니까?")) return false;

	// 파라미터 셋팅
	var params ={};
	// 1. 그리드 헤더 정보
	params.JQGRIDHEADER = headerJsonStr;
   	var headerJsonStr = '{';
   	var colCount = 0;
   	var cols = $('#'+grdId).getGridParam().colModel;
   	for(var i = 0; i < cols.length; i++) {
   		if(cols[i].name == 'rn' || cols[i].name == 'cb' || cols[i].label == undefined) {
			continue;
		}

   		if(cols[i].hidden == false) {
	   		if(colCount != 0) {
	   			headerJsonStr = headerJsonStr + ',';
	   		}
	   		colCount++;
   			headerJsonStr = headerJsonStr + '"' + cols[i].name + '":"' + (cols[i].label == undefined ? cols[i].name : cols[i].label) + '"';
   		}
	}
	headerJsonStr = headerJsonStr + '}';

	// 2. 엑셀업로드할 헤더 정보
	if(!isEmpty(exclHeader)) {
		headerJsonStr = '{';
		colCount = 0;
		for(var i = 0; i < cols.length; i++) {
			if(cols[i].name == 'rn' || cols[i].name == 'cb' || cols[i].label == undefined) {
				continue;
			}
			for(var j = 0; j < exclHeader.length; j++) {
				if(cols[i].name == exclHeader[j]) {
					if(colCount != 0) {
			   			headerJsonStr = headerJsonStr + ',';
			   		}
			   		colCount++;
					headerJsonStr = headerJsonStr + '"' + cols[i].name + '":"' + (cols[i].label == undefined ? cols[i].name : cols[i].label) + '"';
					break;
				}
			}
		}
		headerJsonStr = headerJsonStr + '}';
	}

	// 파일다운로드
	var params ={};
	params.JQGRIDHEADER = headerJsonStr;
	var exclTitle = "엑셀양식";
	if(!isEmpty(dwExclTitle)) exclTitle = dwExclTitle;
	params.filename = exclTitle;
	fileDownFormSubmit({
		url        : '/main/downloadExcelForm.adm',
		params     : params
	});
}