/**
 * 공통 그리드 JS.
 */
UxGrid = function(config) {
	return {
		setcolprop : function(opt) {
			for(i=0; i<opt.length; i++){
//				console.log(opt);
				$("#"+config.gridid).setColProp(opt[i].tgt,opt[i].opt);
			}

		},
		init: function() {
			if(config.gridid == undefined) {
				alert('그리드 ID가 필요합니다');
				return;
			}
			if(config.pagerid == undefined) {
				alert('그리드 Pager ID가 필요합니다');
				return;
			}
			
			var extcolumns = [{name:'JQGRIDCRUD', hidden:true}];
			for(var i = 0; i < config.columns.length; i++) {
				extcolumns.push(config.columns[i]);
			}
			this.gridid = '#' + config.gridid;
			this.pagerid = '#' + config.pagerid;
			this.formid = '#' + config.formid;
			this.selecturl = config.selecturl;
			this.saveurl = config.saveurl;
			this.initval = config.initval||{};
			this.rowNum = config.rowNum;
			this.search = config.search||false;
			config.loadonce = (config.loadonce == undefined ? true : config.loadonce);
			//this.grouping = config.grouping||false;
			//this.groupingView = config.groupingView||{};
			this.grid = $(this.gridid).jqGrid({
				/** *******************************
				 * GRID DEFAULT PROPERTY
				 * ********************************/
				datatype : 'local',
				colModel : extcolumns,
		        cellsubmit : 'clientArray',
		        autowidth : true,
		        rowNum : (this.rowNum == undefined ? _grid_rows_list[0] : this.rowNum),
		        rowList : 5,
		        gridview : true,
		        viewrecords : true,
		        rownumbers : (config.rownumbers == undefined ? true : config.rownumbers),
		        multiSort : (config.multiSort == undefined ? true : config.rownumbers),
		        multiboxonly : true,
		        multipleSearch:false,
		        multipleGroup:false,
		        search: true,
		        emptyrecords : '조회된 데이터가 없습니다.',
		        loadui: 'disable',
		        sortable: false,
		        sortname: '',
		        recordtext : '{0}-{1} / {2}',
		        jsonReader : {
		        	repeatitems : false,
		            page : 'page',
		            total : 'total',
		            root : 'rows',
		            records : 'records'
		        },
		        /** *******************************
				 * GRID USABLE PROPERTY
				 * ********************************/
		        caption : config.gridtitle||'',
		        cellEdit : config.editmode||false,
		        shrinkToFit : (config.shrinkToFit == undefined ? true : config.shrinkToFit),
		        scrollOffset : 0,
		        height : config.height||300,
		        pager : '#'+config.pagerid,
		        /*pager : '',*/
		        multiselect : config.multiselect||false,
		        frozenColumns: config.frozenColumns||false,
		        multiboxonly : config.multiboxonly||false,
		        multipleSearch : config.multipleSearch||false,
		        multipleGroup : config.multipleGroup||false,
		        search :  config.search||false,
		        footerrow : config.footerrow||false,
		        userDataOnFooter : config.userDataOnFooter||false,
		        ajaxSelectOptions : config.ajaxSelectOptions||{},
		        grouping : config.grouping||false,
				groupingView : config.groupingView||{},
				sortname : config.sortname||'',
				data : config.data||undefined,
				hidegrid:(config.hidegrid == undefined ? false : config.hidegrid),
		        treeGrid    : config.treeGrid || undefined,
		        treeGridModel: config.treeGridModel || undefined,
		        treedatatype: config.treedatatype || undefined,
		        ExpandColumn: config.ExpandColumn || undefined,
				loadonce : config.loadonce,
		        /** *******************************
				 * GRID USABLE EVENTS
				 * ********************************/
		        // 1. CELL 선택 시
		        onCellSelect : function(rowid, icol, conts) {
		        	$("#"+config.gridid).jqGrid('setGridParam', {lastrowid : rowid, lastcolidx : icol});
		        	if ($("#"+config.gridid).isBound('onCellSelect')) {
		        		$("#"+config.gridid).trigger('onCellSelect', [rowid, icol, conts]);
		        	}
		        },
		        // 2. DATA LOAD 완료 시
		        gridComplete : function() {
		        	if ($("#"+config.gridid).isBound('gridComplete')) {
		        		$("#"+config.gridid).trigger('gridComplete');
		        	}
		        },
		        // 3. GRID INIT 완료 시
		        loadComplete : function(data) {
		        	if ($("#"+config.gridid).isBound('loadComplete')) {
		        		$("#"+config.gridid).trigger('loadComplete', data);
		        	}
		        },
		        // 4. ROW 더블 클릭 시
		        ondblClickRow : function(rowid, irow, icol) {
		        	if ($("#"+config.gridid).isBound('ondblClickRow')) {
		        		$("#"+config.gridid).trigger('ondblClickRow', [rowid, icol, icol]);
		        	}
		        },
		        // 5. 체크박스 헤더 클릭 시
		        onSelectAll : function(rowids, status) {
		        	if(status) {
						$(rowids).each(function (index, rowid) {
							var row = $("#"+config.gridid).getRowData(rowid);

							if(row.JQGRIDCRUD == "C") {
								$("#"+config.gridid).setCell(rowid, 'STATUS', '행 추가');
								$("#"+config.gridid).setCell(rowid, 'JQGRIDCRUD', 'C');
							} else if (row.JQGRIDCRUD == "U" || row.JQGRIDCRUD == "") {
								$("#"+config.gridid).setCell(rowid, 'STATUS', '수정');
								$("#"+config.gridid).setCell(rowid, 'JQGRIDCRUD', 'U');
							} else if (row.JQGRIDCRUD == "D") {
								$("#"+config.gridid).setCell(rowid, 'STATUS', '삭제');
								$("#"+config.gridid).setCell(rowid, 'JQGRIDCRUD', 'D');
							}
						});

					} else {
						$(rowids).each(function (index, rowid) {
							var row = $("#"+config.gridid).getRowData(rowid);
							//행 추가 제외
							if(row.JQGRIDCRUD != "C") {
								$("#"+config.gridid).setCell(rowid, 'JQGRIDCRUD', null);
								$("#"+config.gridid).setCell(rowid, 'STATUS',  null);
							}

						});

					}


		        	if ($("#"+config.gridid).isBound('onSelectAll')) {
		        		$("#"+config.gridid).trigger('onSelectAll', [rowids, status]);
		        	}
		        },
		        // 6. 그리드 체크박스 또는 ROW 클릭 시
		        onSelectRow : function(rowid, status, e) {


		        	var row = $("#"+config.gridid).getRowData(rowid);

					// 추가되었을 때
					if(status) {
						if(row.JQGRIDCRUD == "C") {
							$("#"+config.gridid).setCell(rowid, 'STATUS', '행 추가');
							$("#"+config.gridid).setCell(rowid, 'JQGRIDCRUD', 'C');
						} else if (row.JQGRIDCRUD == "U" || row.JQGRIDCRUD == "") {
							$("#"+config.gridid).setCell(rowid, 'STATUS', '수정');
							$("#"+config.gridid).setCell(rowid, 'JQGRIDCRUD', 'U');
						} else if (row.JQGRIDCRUD == "D") {
							$("#"+config.gridid).setCell(rowid, 'STATUS', '삭제');
							$("#"+config.gridid).setCell(rowid, 'JQGRIDCRUD', 'D');
						}
					} else {
						//행 추가 제외
						if(row.JQGRIDCRUD != "C") {
							$("#"+config.gridid).setCell(rowid, 'JQGRIDCRUD', null);
							$("#"+config.gridid).setCell(rowid, 'STATUS',  null);
						}
					}

		        	/* if (!config.multiselect || status) { */
			        	if ($("#"+config.gridid).isBound('onSelectRow')) {
			        		$("#"+config.gridid).trigger('onSelectRow', [rowid, status]);
			        	}
		        	/* } */
		        },
		        // 7. CELL EDIT 후 CELL 상태 처리 시
		        afterSaveCell : function(rowId, cellName, value, iRow, iCol) {
		        	var row = $("#"+config.gridid).getRowData(rowId);

		        	if(row.JQGRIDCRUD != "C") {
		        		$("#"+config.gridid).setCell(rowId, 'JQGRIDCRUD', 'U');


		        		$("#"+config.gridid).setCell(rowId, 'STATUS', '수정');

						var chk = $("input:checkbox[id='jqg_" + config.gridid + "_"+ rowId +"']").is(":checked");
						if(chk != true) {

							$("#"+config.gridid).jqGrid('setSelection', rowId, true);
						}

		        		/*if ($("#"+config.gridid).isBound('afterSaveCell')) {
		        			$("#"+config.gridid).trigger('afterSaveCell', [rowId, cellName, value, iRow, iCol]);
		        		}*/
		        	}
		        },
		        //8. slectRow 전에 처리할 내용이 있을시
		        beforeSelectRow : function (rowid, status, e){
		        	if ($("#"+config.gridid).isBound('beforeSelectRow')) {
		        		$("#"+config.gridid).trigger('beforeSelectRow', [rowid, status]);
		        	}

		        },
		        /** *******************************
				 * GRID USABLE EVENTS
				 * ********************************/
		        onPaging : function(action) {
		        	var page = $("#"+config.gridid).jqGrid('getGridParam', 'page');
		        	var rows = $('.ui-pg-selbox').val();
		        	if(action == 'next') {
		        		page++;
		        	}else if(action == 'prev') {
		        		page--;
		        	}else if(action == 'first') {
		        		page = 1;
		        	}else if(action == 'last') {
		        		page = $('#'+config.gridid).jqGrid('getGridParam', 'lastpage');
		        	}else if(action == 'user') {
		        		page = $('.ui-pg-input').val();
		        		var lastpage = $('#'+config.gridid).jqGrid('getGridParam', 'lastpage');
		        		if(page > lastpage) {
		        			page = lastpage;
		        		}else if (page < 1) {
		        			page = 1;
		        		}
		        	}else if (action == 'records') {
		        		page = 1;
		        	}
		        	$('#'+config.gridid).jqGrid('setGridParam', {page:page, rowNum:rows});
		        	var select = $('#'+config.gridid).jqGrid('getGridParam', 'select');
					eval(select());
					return 'stop';
		        },
		        onSortCol: function(colnm, icol, sortorder) {
		        	if(config.loadonce){
		        		return null;
		        	}else{
		        		$('#'+config.gridid).jqGrid('setGridParam',{sortname:colnm, sortorder:sortorder});
			        	var select = $('#'+config.gridid).jqGrid('getGridParam','select');
			        	eval(select());
			        	if($('#'+config.gridid).jqGrid('getGridParam').rowNum == 0) {
			        		$("#"+config.gridid+" > tbody").find(".search_blank").css("display", "block");
			        	} else {
			        		$("#"+config.gridid+" > tbody").find(".search_blank").css("display", "none");
			        	}
						return 'stop';
		        	}
		        },
		        /** *******************************
				 * USER DEFINE FUNCTION OR PROPERTY
				 * ********************************/
		        lastrowid : 0,
		        lastcolidx : 0,
		        seloptions : {},
		        saveoptions : {},
		        removeoptions : {},
		        // 조회
		        select : function() {
		        	var seloptions = $("#"+config.gridid).jqGrid('getGridParam', 'seloptions');
					var griddata = {'page':$("#"+config.gridid).jqGrid('getGridParam', 'page'),
							        'rows':$("#"+config.gridid).jqGrid('getGridParam', 'rowNum'),
							        'sidx':$("#"+config.gridid).jqGrid('getGridParam', 'sortname'),
							        'sord':$("#"+config.gridid).jqGrid('getGridParam', 'sortorder'),
							        '_pre_url':parent.preUrl.getPreUrl(),
							        '_mnu_seq' : _menu_id};
					griddata = $.extend(griddata, seloptions.data||{});
					var pin = config.formid == undefined ? griddata : $.extend(griddata, $('#'+config.formid).serializeObject());
					var _cnt = 0;
					setTimeout(function() {
						ajax({
							url : config.selecturl,
							data : pin,
							beforeSend: function() {
								var loadingHtml = '';
								var imgPath =  _context + "/resources/pandora3/images/common/img_loading_2.gif";
								
								    loadingHtml += '<div class="loading">';
									loadingHtml += '<img src="'+ imgPath +'" alt="loading" />';
									loadingHtml += '<p class="desc">데이터를 불러오고 있습니다';
									loadingHtml += '<em>잠시만 기다려주세요</em>';
									loadingHtml += '</p>';
									loadingHtml += '</div>';
									
								$(".frameWrap").prepend(loadingHtml);

							},
							success: function(data) {
								if(data.RESULT == _boolean_success) {

									$("#"+config.gridid).jqGrid('clearGridData', true);
									$("#"+config.gridid).jqGrid('setGridParam', {lastrowid:0, lastcolidx:0});

									if(config.pagerid === '') {
										$("#"+config.gridid).jqGrid('setGridParam', {rowNum:data.rows.length});
									}

									// 2019.11.08 그리드 내부 데이터 정렬 사용을 위해 변경
									$("#"+config.gridid).jqGrid('setGridParam', {data:data.rows});
									 $("#"+config.gridid)[0].addJSONData(data);
//									$("#"+config.gridid).jqGrid('addRowData', 1, data.rows, 0);

									var seloptions = $("#"+config.gridid).jqGrid('getGridParam','seloptions');

									if(config.shrinkToFit === false) {
										if($("#"+config.gridid).height() == 0) {
											$("#"+config.gridid).removeClass("off");
										} else {
											$("#"+config.gridid).addClass("off");
										}
									} else {
										$("#"+config.gridid).addClass("off").closest(".ui-jqgrid-bdiv").addClass("off");

										if($("#"+config.gridid).closest(".ui-jqgrid-bdiv").height() < $("#"+config.gridid).closest(".ui-jqgrid-bdiv")[0].scrollHeight){
											$("#"+config.gridid).closest(".ui-jqgrid").addClass("scroll");
										} else {
											$("#"+config.gridid).closest(".ui-jqgrid").removeClass("scroll");
										}
									}
									_cnt = data.records;

									if(_cnt == 0 || _cnt == undefined){
										_cnt = data.rows.length;
									}

									if(seloptions.success) {
										eval(seloptions.success());
									}
								}else if(data.RESULT == _boolean_expired) {
									alert("세션이 종료되었습니다. 로그인을 다시해 주시기 바랍니다.");
									location.href = "../main/login/forward.login.do";
								}else {
									alert("조회에 실패하였습니다.");
								}
							},
							complete: function(data) {
								setTimeout(function(){
									$("div.loading").remove();
									 initPage(config.gridid, config.pagerid, true, 10 );
									 if(_cnt == 0){
										 var colmnsInfo = $('#'+ config.gridid).jqGrid('getGridParam', 'colModel');

										 $("#"+config.gridid+" > tbody").append("<tr><td class='search_blank' style='overflow:hidden; height:"+($("#"+config.gridid).closest(".ui-jqgrid-bdiv").height() - 17)+"px; line-height:"+$("#"+config.gridid).closest(".ui-jqgrid-bdiv").height()+"px' align='center' colspan='"+colmnsInfo.length+"'>검색 결과가 없습니다.</td></tr>");
									 }
								}, 1000);
							},
							loadComplete: function(data) {
							}
						});
					});
				}
			});

			// EVENT LOAD
			var event = config.events||{};
			$.each(event, function(name, fn) {
				$("#"+config.gridid).bind(name, fn);
			});


			// 초기화
			this.initdata();

            // 그리드 페이징 영역
            this.grid.navGrid(this.pagerid, {edit:false, add:false, del:false, search:this.search, refresh:false},{},{},{},{multipleSearch:true,showQuery: true})

            // 그리드 버튼 조회
            if( config.gridBtnYn == 'Y')
            	getBtnListSetting();

			if(config.rownumbers == undefined || config.rownumbers == true) {
				$("#"+config.gridid).jqGrid("setLabel", "rn", "NO");
			}
            
            initPage(config.gridid, config.pagerid, true, 10 );
            highlight(config.gridid);

	    },
	    /** *******************************
		 * JQGRID FUNCTION
		 * ********************************/
		// 1. JSON ADD
		addJSONData : function(json) {
//			this.grid[0].addJSONData(json);
			var req = this.grid[0].addLocalData();
		    this.grid[0].addJSONData(req);
		},
		// 2. ROW ADD
		addRowData : function(rowid, data, position, srcrowid) {
			this.grid.addRowData(rowid, data, position, srcrowid);
		},
		// 3. XML ADD
		addXmlData : function(data) {
			this.grid[0].addXmlData(data);
		},
		// 4. GRID 데이터 초기화
		clearGridData : function() {
			this.grid.clearGridData();
			this.initdata();
		},
		// 5. ROW DEL
		delRowData : function(rowid) {
			this.grid.delRowData(rowid);
		},
		// 6. CELL 추출
		getCell : function(rowid, icol) {
			return this.grid.getCell(rowid, icol);
		},
		// 7. GRID ROW ID ARRAY 추출
		getDataIDs : function() {
			return this.grid.getDataIDs();
		},
		// 8. GRID PARAM 추출
		getGridParam : function(nm) {
			return this.grid.getGridParam(nm);
		},
		// 9. ROW DATA 추출(ROWID EMPTY > ALL)
		getRowData : function(rowid) {
			return this.grid.getRowData(rowid);
		},
		// 10. COLUMN 정보 추출
		getRowHeader : function() {
			return this.grid.getGridParam().colModel;
		},
		// 11. 선택 해제
		resetSelection : function() {
			this.grid.resetSelection();
		},
		// 12. ROW 데이터 원복
		restoreRow : function(rowid) {
			this.grid.restoreRow(rowid);
		},
		// 13. 그리드 CAPTION 설정
		setCaption : function(caption) {
			this.grid.setCaption(caption);
		},
		// 14. CELL 데이터 설정
		setCell : function(rowid, colnm, data, cssclass, properties, forceup) {
			$("#" + $.jgrid.jqID(rowid)).addClass("edited");
			this.grid.setCell(rowid, colnm, data, cssclass, properties, forceup);
		},
		// 15. GRID PROPERTY 설정
		setGridParam : function(object) {
			this.grid.setGridParam(object);
		},
		// 16. HEIGHT 설정 (PIXCEL OR PERCENT OR AUTO)
		setGridHeight : function(ht) {
			this.grid.setGridHeight(ht);
		},
		// 17. WIDTH 설정 (PIXCEL OR PERCENT OR AUTO)
		setGridWidth : function(wd) {
			this.grid.setGridWidth(wd);
		},
		// 18. LABEL 설정
		setLabel : function(colnm, data, cssclass, properties) {
			this.grid.setLabel(colnm, data, cssclass, properties);
		},
		// 19. row data 설정
		setRowData : function(rowid, data, cssprop) {
			this.grid.setRowData(rowid, data, cssprop);
		},
		// 20. SELECTION 설정
		setSelection : function(rowid, onselectrow) {
			this.grid.setSelection(rowid, onselectrow);
		},
		// 21. COLUMN SHOW
		showCol : function(colnm) {
			this.grid.showCol(colnm);
		},
		// 22. COLUMN HIDE
		hideCol : function(colnm) {
			this.grid.hideCol(colnm);
		},
		// 23. JQID 추출
		jqID : function(rowid) {
			this.grid.jqID(rowid);
		},
		// 24. GRID 객체 추출
		getGrid : function() {
			return this.grid;
		},
		/** *******************************
		 * USER DEFINE FUNCTION
		 * ********************************/
		// 1. 선택된 ROW ID 추출
		getSelectRowIDs : function() {
			return config.multiselect? this.grid.getGridParam('selarrrow') : (this.grid.getGridParam('selrow') == null ? [] : [this.grid.getGridParam('selrow')]);
		},
		// 2. 선택된 ROW 추출
		getSelectRows : function() {
			var rows = [];
			var rowids = this.getSelectRowIDs();
			for(var i = 0; i < rowids.length; i++) {
				rows.push(this.grid.getRowData(rowids[i]));
			}
			return rows;
		},
		// 3. CELL 마지막 POSITION 추출
		getCellLastPosition : function() {
			var lastrowid = this.grid.jqGrid('getGridParam', 'lastrowid');
			var lastcolidx = this.grid.jqGrid('getGridParam', 'lastcolidx');
			return {rowid:lastrowid, colidx:lastcolidx};
		},
		// 4. COLUMN MODEL 추출
		getColModel : function(colidx) {
			var cols = this.grid.jqGrid('getGridParam', 'colModel');
			if(colidx == undefined) {
				return cols;
			}else {
				return cols[colidx];
			}
		},
		// 5. COLUMN 명 추출
		getColName : function(colidx) {
			var cols = this.grid.jqGrid('getGridParam', 'colModel');
			return cols[colidx].name;
		},
		// 6. 편집 완료
		editcomplete : function() {
			var lastrowid = this.grid.jqGrid('getGridParam', 'lastrowid');
			var lastcolidx = this.grid.jqGrid('getGridParam', 'lastcolidx');
			if(lastrowid > 0 && lastcolidx > 0) {
				this.grid.editCell(lastrowid, lastcolidx, false);
			}else {
				var ids = this.grid.getDataIDs();
		        var cols = this.grid.getGridParam().colModel;
		        for(var k = 0; k < ids.length; k++) {
			        for(var i = 0; i < cols.length; i++) {
			            if($(this.gridid +' tr#' + ids[k] + ' td:eq(' + i + ')').hasClass('edit-cell')) {
			                this.grid.editCell(ids[k], i, false);
			            }
			        }
		        }
			}
		},
		// 6. 서브합계 추출
		subsum : function() {
			var sum =  this.grid.jqGrid('getCol', 'PRJ_SUM', false, 'sum');
			this.grid.jqGrid('footerData', 'set', {PRJ_SUM:sum});
			return sum;
		},
		// 7. 초기화 처리
		initdata : function() {
			var result = {total:1, records:0, page:1, rows:[]};
			if(config.data != undefined && config.data != "undefined"){
				result = config.data
			}
			this.grid[0].addJSONData(result);
			// 강제 가로스크롤 생성
            $(".jqgfirstrow").css("height","1px");
            $(".jqgfirstrow").css("color", "#FFFFFF");
            // 강제 그리드 풋터 WIDTH 설정
            $("#"+config.gridid+"_pager_center").css("width", "200px");
		},
		// 8. 조회
		retreive : function(seloptions) {
			this.grid.jqGrid('setGridParam',{seloptions:seloptions||{}, page : 1});
			var select = this.grid.jqGrid('getGridParam', 'select');
			eval(select());
		},
		// 9. 행추가 처리
		add : function(init) {
			// 행추가 시 그리드 초기화(행상태 C:INSERT 제외)
			var isAllAdd = true;
			var rowData = this.getRowData();
			for(var i = 0; i < rowData.length; i++) {
				this.grid.editCell(i, 0, false);
				if(rowData[i].JQGRIDCRUD != 'C') {
					isAllAdd = false;
					break;
				}
			}
			/*
			if(!isAllAdd) {
				this.clearGridData();
			}
			*/
			// 행추가 및 행상태 변경(C:INSERT)
			var maxRowId = 0;
			var record = $.extend(this.initval, init||{});
			var pin = $.extend({JQGRIDCRUD:'C'}, record);
			var rowIds = this.grid.getDataIDs();

			// 2019.11.08 그리드 내부 데이터 정렬 사용을 위해 변경
			var intRowIds = rowIds.map(function(x) { return parseInt(x.replace(/[^0-9]/gi, '')); });

			if(intRowIds.length > 0 ) {
				maxRowId = Math.max.apply(null, intRowIds) + 1;
			}


			///var rowId = this.grid.getGridParam("reccount")  + 1 ; // first 시 로우아이디
			//this.grid.jqGrid('addRowData', rowIdsLen + 1, pin, "last"); // --  > last : 행 마지막번째 행으로 추가
			this.grid.jqGrid('addRowData', 'jqg' + maxRowId, pin, "first"); // first : 행 첫번째 행으로 추가
			this.grid.setCell('jqg' + maxRowId, 'STATUS', '추가');
			this.grid.setSelection('jqg' + maxRowId, true);

			// 2019.11.08 그리드 내부 데이터 정렬 사용을 위해 변경
			if($(this.gridid).jqGrid('getGridParam', 'rowNum') < rowIds.length + 1)
				$(this.gridid).jqGrid('setGridParam', {rowNum : rowIds.length + 1});

			$("#"+this.grid[0].id+" > tbody").find(".search_blank").css("display", "none");

			return maxRowId + 1;
		},
		// 8. 행삭제 OR 삭제 처리(D:DELETE)
		remove : function(removeoptions) {
			this.grid.jqGrid('setGridParam', {removeoptions:removeoptions||{}});

			// 선택된 행상태 변경(D:DELETE, 행상태 C:INSERT인 경우 제외)
			var rowIds = this.getSelectRowIDs();
			var delList1 = []; // 삭제할 열 배열
			for(var i = 0; i < rowIds.length; i++) {
				var row = this.grid.jqGrid('getRowData', rowIds[i]);

				if(row.JQGRIDCRUD == 'C') { // 1. 물리적삭제
					delList1.push(rowIds[i]);
				}else { // 2. DB삭제
					this.grid.setCell(rowIds[i], 'JQGRIDCRUD', 'D');
					this.grid.setCell(rowIds[i], 'STATUS', '삭제');
				}
			}

			// DB 삭제할 데이터를 배열에 추가
			var rows = this.grid.getRowData();
			var delList2 = []; // 삭제할 열 배열
			for(var i = 0; i < rows.length; i++) {
				this.grid.editCell(i, 0, false);

				if(rows[i].JQGRIDCRUD == 'D') {
					delList2.push(rows[i]);
				}
			}
			// 삭제할 행이 없는 경우
			if(delList1.length == 0 && delList2.length == 0) {
				alert('삭제할 행을 선택해주세요.');
				return;
			}

			// 삭제 Confirm 창
			var delList1Len = delList1.length;
			var delList2Len = delList2.length;

			// 1. 물리적삭제
			if(delList1Len > 0) {
				for(var i = 0; i < delList1Len; i++) {
					this.grid.jqGrid('delRowData', delList1[i]);

				}
				if(this.grid.getRowData().length == 0) {
					$("#"+this.grid[0].id+" > tbody").find(".search_blank").css("display", "block");
				}
				//return;
			}
		},
		// 10. 저장(C:INSERT, U:UPDATE, D:DELETE)
		save : function(saveoptions) {
			this.grid.jqGrid('setGridParam', {saveoptions:saveoptions||{}});
			var cols = this.grid.jqGrid('getGridParam', 'colModel');

			// 강제 포커스 OUT
			var rows = this.grid.getRowData();
			for(var i = 0; i < rows.length; i++) {
				this.grid.editCell(i, 0, false);
			}

			// 유효성 검사
			var rowIds = this.grid.getDataIDs();
			for(var i = 0; i < rowIds.length; i++) {
				var row = this.grid.getRowData(rowIds[i]);
				if(row.JQGRIDCRUD == 'C' || row.JQGRIDCRUD == 'U') {
					// 필수값 체크
					for(var k = 0; k < cols.length; k++) {
						if(cols[k].required != undefined && cols[k].required) {
							var val = this.grid.getCell(rowIds[i], cols[k].name);
							if(val == '') {
								alert(cols[k].label+'(은)는 필수 입력항목입니다. 값을 입력해 주세요.');
								$("#"+config.gridid).editCell(parseInt(i+1, 10), k, true);
								return;
							}
						}
						// 임시값 입력
						if (cols[k].formatter == 'date' && !cols[k].editable) {
							this.grid.setCell(rowIds[i], cols[k].name, $.timestampToString(new Date()));
						}
					}
				}
			}

			// 삽입, 갱신할 데이터를 배열에 추가
			var saveList = []; // 삽입, 갱신할 열 배열
			for(var i = 0; i < rowIds.length; i++) {
				var row = this.grid.getRowData(rowIds[i]);
				if(row.JQGRIDCRUD == 'C' || row.JQGRIDCRUD == 'U' || row.JQGRIDCRUD == 'D') {
					saveList.push(row);
				}
			}

			// 저장할 데이터이 없는 경우
			var saveListLen = saveList.length;
			if(saveListLen == 0) {
				alert('저장할 데이터가 없습니다. 확인해주세요.');
				var result = false
				return result;
			}

			// 저장 Confirm 창
			var savConf = confirm("저장하시겠습니까?");
			if(savConf) {
				var saveUrl = this.saveurl;
				var reLoadYn = false;
				setTimeout(function() {
					ajax({
						url : saveUrl,
						method : 'POST',
						data : {JQGRIDSIZE : saveListLen, JQGRIDDATA : JSON.stringify(saveList),_pre_url : parent.preUrl.getPreUrl(),_mnu_seq : _menu_id },
						success : function(data) {
							if(data.RESULT == _boolean_success) {
								// 저장 정상 메세지 출력
		                        alert("정상적으로 저장 되었습니다.");

								// 저장 후 CALLBACK 함수
								var saveoptions = $("#"+config.gridid).jqGrid('getGridParam', 'saveoptions');
								if (saveoptions.success) {
									eval(saveoptions.success());
								}

								// 재조회 & 메세지 출력
								setTimeout(function() {
									// 재조회
									var select = $('#'+config.gridid).jqGrid('getGridParam', 'select');
									eval(select());
								});
							}else if(data.RESULT == _boolean_expired) {
								alert("세션이 종료되었습니다. 로그인을 다시해 주시기 바랍니다.");
								location.href = "../main/login/forward.login.do";
							}else {
								alert("저장에 실패하였습니다.");
							}
							// 저장 후 CALLBACK 함수
							var saveoptions = $("#"+config.gridid).jqGrid('getGridParam', 'saveoptions');
							if (saveoptions.success) {
								eval(saveoptions.success());
							}

							// 재조회 & 메세지 출력
							setTimeout(function() {
								// 재조회
								var select = $('#'+config.gridid).jqGrid('getGridParam', 'select');
								eval(select());
							});
						}
					});
				});
			}else {
				return;
			}
		},
		// 비밀번호 초기화 로직
		pwInit: function(saveoptions){
	        //alert(JSON.stringify(mergelist));
	        ajax({
	            url: this.pwIniturl,
	            method: 'POST',
	            data: {JQGRIDSIZE:mergelist.length,JQGRIDDATA:JSON.stringify(mergelist)},
	            success: function(data) {
	                var saveoptions = $("#"+config.gridid).jqGrid('getGridParam','saveoptions');
	                // 저장후 callback 함수
					if (saveoptions.success) {
						eval(saveoptions.success());
					}

	                var select = $('#'+config.gridid).jqGrid('getGridParam','select');
					eval(select());

					alert("비밀번호가 초기화 되었습니다");
	            }
	        });
		},
		// 2019.03.06 추가
		// colId	: 그리드 컬럼 name
		// val		: 컬럼 값
		// return	: 현재 그리드에 선택된 Row의 Json 배열
		getSelectedRowJson : function(){
			var result = [];
			var idx = this.getSelectRowIDs();

			for(var i=0 ; i<idx.length ; i++)
				result.push(this.getRowData(idx[i]));

			return result;
		},
		// 2019.03.06 추가
		// colId	: 그리드 컬럼 name
		// val		: 컬럼 값
		// return	: 조건에 해당하는 Json 배열
		getRowJsonByValue : function(colId, val){
			var data = this.getRowData();

			if(isEmpty(colId) || isEmpty(val) || data.length < 1)
				return [];
			else
				return data.filter(function(temp){return temp[colId] == val;});
		},
		// 2019.03.06 추가
		// colId	: 그리드 컬럼 name
		// val		: 컬럼 값
		// return	: 조건에 해당하는 데이터의 Row Index 배열
		getRowIndexByValue : function(colId, val){
			if(isEmpty(colId) || isEmpty(val))
				return idx;

			var result  = [];
			var data = this.getRowData();

			if(data.length < 1)
				return [];
			else
				data.filter(function(temp, idx){if(temp[colId] == val) result.push(idx + 1);});

			return result;
		},
		// 2019.03.06 추가
		// rowIdx	: Row Index (1부터 시작)
		// colIdx	: Column Index (1부터 시작 / 보이지 않는 컬럼은 Count 제외)
		setCellFocus : function(rowIdx, colIdx){

			var row = $(this.gridid + " tr").eq(parseInt(rowIdx));

			if(row.length < 1)
			 	return;

			var cell = $(row).find("td:visible").eq(colIdx);

			if(cell.length < 1)
				return;

			$("#" + config.gridid).closest(".ui-jqgrid-bdiv").scrollTop($(cell)[0].offsetTop);

			$(cell).trigger('click');
		},
		// 2019.03.14 추가
		// return	: 마우스 클릭으로 선택된 셀의 row, col 배열 (체크박스로 선택된 행은 미포함)
		getFocusedCellIndex : function(){

			var temp = $(".edit-cell");

			if(temp.length < 1)
				return [{row : 0, col : 0}];

			var result = [];

			for(var i=0 ; i<temp.length ; i++)
			{
				var row = parseInt($(temp[i]).parent().attr("id"));
				var col = $("#" + config.gridid + " #" + row + " td:visible").index(temp[i]) + 1;

				result.push({row : row, col : col});
			}

			return result;
		}
	}
};

// 동적 그리드 생성
function fn_UxGrid(config, url, obj) {
	var colInfo = new Array();
	if(isEmpty(config.columns)){
		if(isNotEmpty(url)) {
			ajax({
				url : url,
				method : 'POST',
				data : {},
				success : function(data) {
					// key : name , label
					colInfo = data;
				}
			});
		}
		else if(isNotEmpty(obj)) colInfo = obj;
	}
	var columns = new Array();

	for(i=0; i<colInfo.length; i++) {
		/*var column = {
			label : colInfo[i].label
			,name : colInfo[i].name
		}*/
		columns.push(colInfo[i]);
	}
	if(columns.length > 0) config.columns = columns;

	var object = new UxGrid(config);

	return object;
}

//숫자만 입력받도록 하는 함수
function onlyNum(element){
	var result = false;
	if(element.keyCode < 48 || element.keyCode > 57){
		 result = false;
	}else{
		 //좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
		 if(element.keyCode == 8 || element.keyCode == 9 || element.keyCode == 37 || element.keyCode == 39|| element.keyCode == 46 ){
			 result = false;
		 }else{
			 result = true;
		 }
	}
	return result;
}
// 숫자값 범위 0 ~ 1000 까지 입력 받도록 수정
function rangeNum(oldVal, element){
	var result = false;
	var newVal = element.value;
    if(newVal >= 0 && newVal <= 1000){
    	result = true;
    }else{
        alert('0 ~ 1000 사이 숫자를 입력해 주세요.');
        element.value = oldVal;
        result = false;
    }
    return result;
}

// 이메일 형식
function chkEmail(element, oldVal){
	if(element.value == ""){
		// 입력된 값이 없을 경우에 전화번호가 필수값이 아니기 때문에 유효성 체크 하지 않음
		result = true;
	}else{
		// 입력된 값이 있을 경우에 유효성 체크
		var result = false;
		var newVal = element.value
		/*var reg = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;*/
		var reg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if(!reg.test(newVal)){
			alert("이메일 형식에 맞춰주세요.");
			element.value = oldVal;
			result = false;
		}else{
			result = true;
		}
	}
    return result;
}

// 전화번호/휴대전화 형식 체크
function chkTelNo(element, oldVal, gubun){
	var note = "";
	if(element.value == ""){
		// 입력된 값이 없을 경우에 전화번호가 필수값이 아니기 때문에 유효성 체크 하지 않음
		result = true;
	}else{
		// 입력된 값이 있을 경우에 유효성 체크
		var result = false;
		var newVal = element.value;
		var reg = "";
		if(gubun == "tel"){
			reg = /\b\d02|\d{2,3}[)]\d{3,4}[-]\d{4}\b/g;
			note = "전화번호 형식에 맞춰주세요."
		}else if(gubun == "cell"){
			reg = /\b\d01|\d{3}[-]\d{3,4}[-]\d{4}\b/g;
			note = "휴대전화 형식에 맞춰주세요."
		}
		if(!reg.test(newVal)){
			alert(note);
			element.value = oldVal;
			result = false
		}else{
			result = true;
		}
	}
	return result;
}

function excelDownload(gridId){
		   	var list = [];
		   	// column name put
		   	var jsonString = '{';
		   	var colCount = 0;
		   	var cols = $('#'+gridId).getGridParam().colModel;
//		   	console.log(cols);
		   	for (var i = 0; i < cols.length; i++) {
		   		if (cols[i].name == 'rn' || cols[i].name == 'cb' || cols[i].label == undefined) {
	    			continue;
	    		}

		   		if(cols[i].hidden == false){
			   		if (colCount != 0) {
			   			jsonString = jsonString + ',';
			   		}
			   		colCount++;
		   			jsonString = jsonString + '"'+cols[i].name + '":"' + (cols[i].label == undefined? cols[i].name:cols[i].label)+'"';
		   		}
	    	}
	    	jsonString = jsonString + '}';
			var rows = $('#'+gridId).getRowData();
			if (rows.length == 0) {
				alert('엑셀 다운로드를 위한 데이터가 존재 하지 않습니다');
				return;
			}
//			console.log(rows);
			for (var i = 0; i < rows.length; i++) {
				if (rows[i].JQGRIDCRUD != 'C') {
					list.push(rows[i]);
				}
			}

			popup({url:url
				, params:{JQGRIDSIZE:list.length,JQGRIDHEADER:jsonString,JQGRIDDATA:JSON.stringify(list)}
             , winname:"_hidden"
             , title:""
             , action:true
             , scrollbars:false
             , autoresize:false
         });
}

function gridExcelDownload(gridId, url, param ){
   	var list = [];
   	// column name put
   	var jsonString = '{';
   	var colCount = 0;
   	var cols = $('#'+gridId).getGridParam().colModel;
//   	console.log(cols);
   	for (var i = 0; i < cols.length; i++) {
   		if (cols[i].name == 'rn' || cols[i].name == 'cb' || cols[i].label == undefined) {
			continue;
		}

   		if(cols[i].hidden == false){
	   		if (colCount != 0) {
	   			jsonString = jsonString + ',';
	   		}
	   		colCount++;
   			jsonString = jsonString + '"'+cols[i].name + '":"' + (cols[i].label == undefined? cols[i].name:cols[i].label)+'"';
   		}
	}
	jsonString = jsonString + '}';
	var rows = $('#'+gridId).getRowData();
	if (rows.length == 0) {
		alert('엑셀 다운로드를 위한 데이터가 존재 하지 않습니다');
		return;
	}
//	console.log(rows);
	for (var i = 0; i < rows.length; i++) {
		list.push(rows[i]);
	}
	
	var footterObj = $('#'+gridId).footerData('get');
	
	if(Object.keys(footterObj).length != 0 ) {
		list.push(footterObj);
	}
	
    fileDownFormSubmit({
		url        : url
		, params:{JQGRIDSIZE:list.length,JQGRIDHEADER:jsonString,JQGRIDDATA:JSON.stringify(list),fileName:param.fileName}
	});
}

function AdvencedExcelDownload(gridId, url, params, formId){
   	var list = [];
   	// column name put
   	var jsonString = '{';
   	var colCount = 0;
   	var cols = $('#'+gridId).getGridParam().colModel;
//   	console.log(cols);
   	for (var i = 0; i < cols.length; i++) {
   		if (cols[i].name == 'rn' || cols[i].name == 'cb' || cols[i].name == 'STATUS' || cols[i].label == undefined) {
			continue;
		}
   		cols[i].label = cols[i].label.replace(/(<br>|<br\/>|<br \/>)/g, '');

   		if(cols[i].hidden == false){
	   		if (colCount != 0) {
	   			jsonString = jsonString + ',';
	   		}
	   		colCount++;
   			jsonString = jsonString + '"'+cols[i].name + '":"' + (cols[i].label == undefined? cols[i].name:cols[i].label)+'"';
   		}
	}
	jsonString = jsonString + '}';
	var rows = $('#'+gridId).getRowData();
	if (rows.length == 0) {
		alert('엑셀 다운로드를 위한 데이터가 존재 하지 않습니다');
		return;
	}
//	for (var i = 0; i < rows.length; i++) {
//		if (rows[i].JQGRIDCRUD != 'C') {
//			list.push(rows[i]);
//		}
//	}
    params.JQGRIDHEADER=jsonString;
//    console.log(params);
	/*
    popup({url:url
		, params:params
     , winname:"_hidden"
     , title:""
     , action:true
     , scrollbars:false
     , autoresize:false
 });
 	*/
    // 2019.03.04 조회조건 파라미터 추가
    if(isEmpty(formId))
    	formId = "search";

    var temp = $("#" + formId).serializeArray();

	for(var i=0 ; i<temp.length ; i++)
		if(isNotEmpty(temp[i].value))
			params[temp[i].name] = temp[i].value;

    // IFRAME 형식으로 변경
    fileDownFormSubmit({
		url        : url,
		params     : params
	});
}

// 중복데이터 체크
function isDuplicateGridData(gridObj, data) {
	var rows = gridObj.getRowData();

	for (var k = 0; k < rows.length; k++) {
        if (rows[k][data.key] == data.value) {
            return true;
        }
    }

	return false;
}

//grid keyup change char event 발생
function changeCharEvent(e, callBackFunc){
	/*if(e.keyCode >= 48 && e.keyCode <= 90){
		callBackFunc();
	}*/
	if(e.keyCode != 13 || e.keyCode != 9){
		callBackFunc();
	}
}

//grid keydown enter event 발생
function enterOrTabKeyEvent(e, callBackFunc){
	if(e.keyCode == 13 || e.keyCode == 9){
		callBackFunc();
	}
}


/**
 * 그리드 페이징
 *
 * @param gridId
 * @param pagerId
 * @param pI      : 페이지 정보를 나타낼 것인지 / boolean / 생략시 false
 * @param pageCnt : 한 페이지에 보여줄 페이지 수  (ex:1 2 3 4 5)
 */
function initPage(gridId, pagerId, pagerYn, pageCount){
	 if(pagerYn == null || pagerYn == "")
		 pagerYn = false;

	 // 2019.11.08 그리드 내부 데이터 정렬 사용을 위해 변경
	 if(isEmpty(pagerId))
		 return;

 // 현재 페이지
 var currentPage = $('#'+gridId).getGridParam('page');
 // 전체 리스트 수
 var totalSize = $('#'+gridId).getGridParam('records');
 // 그리드 데이터 전체의 페이지 수
 var totalPage = Math.ceil(totalSize/$('#'+gridId).getGridParam('rowNum'));

 // 전체 페이지 수를 한화면에 보여줄 페이지로 나눈다.
 var totalPageList = Math.ceil(totalPage/pageCount);
 // 페이지 리스트가 몇번째 리스트인지
 var pageList=Math.ceil(currentPage/pageCount);
 // 페이지 리스트가 1보다 작으면 1로 초기화
 if(pageList<1) pageList=1;
 // 페이지 리스트가 총 페이지 리스트보다 커지면 총 페이지 리스트로 설정
 if(pageList>totalPageList) pageList = totalPageList;

 // 시작 페이지
 var startPageList=((pageList-1)*pageCount)+1;
 // 끝 페이지
 var endPageList=startPageList+pageCount-1;
 // 시작 페이지와 끝페이지가 1보다 작으면 1로 설정
 // 끝 페이지가 마지막 페이지보다 클 경우 마지막 페이지값으로 설정
 if(startPageList<1)       startPageList=1;
 if(endPageList>totalPage) endPageList=totalPage;
 if(endPageList<1)         endPageList=1;

 // 페이징 DIV에 넣어줄 태그 생성변수
 var pageInner="";

 if(currentPage <=1 || totalSize <= 1){
	pageInner+="<li class='leftOne'><span class='pageNum typeImg'><img src='" + _context + "/resources/pandora3/images/common_new/img_page_left_arrow2.png' alt=''></span></li>";
	pageInner+="<li class='leftTwo'><span class='pageNum typeImg'><img src='" + _context + "/resources/pandora3/images/common_new/img_page_left_arrow1.png' alt=''></span></li>";
 } else {
	pageInner+="<li class='leftOne'><a class='pageNum typeImg' href='javascript:firstPage(\""+ gridId +"\");' title='첫 페이지로 이동'><img src='" + _context + "/resources/pandora3/images/common_new/img_page_left_arrow2.png' alt=''></a></li>";
	pageInner+="<li class='leftTwo'><a class='pageNum typeImg' href='javascript:prePage(\""+ gridId +"\", "+ currentPage +");' title='이전 페이지로 이동'><img src='" + _context + "/resources/pandora3/images/common_new/img_page_left_arrow1.png' alt=''></a></li>";
 }


 // 페이지 숫자를 찍으며 태그생성 (현재페이지는 강조태그)
 for(var i=startPageList; i<=endPageList; i++)
 {
	  var titleGoPage = i + "페이지로 이동";

	  if(i==currentPage){
	   pageInner = pageInner +"<li class='on'><span class='pageNum'>"+(i)+"</span></li>";
	  }else{
	   pageInner = pageInner +"<li><a class='pageNum' href='javascript:goPage(\""+ gridId +"\", "+(i)+");' id='"+(i)+"' title='"+ titleGoPage +"'>"+(i)+"</a></li>";
	  }
 }

 // 다음 페이지 리스트가 있을 경우
 if(totalSize <= 1 || currentPage == totalPage){
	 pageInner+="<li class='rightOne'><span class='pageNum typeImg'><img src='" + _context + "/resources/pandora3/images/common_new/img_page_right_arrow1.png' alt=''></span></li>";
	 pageInner+="<li class='rightTwo'><span class='pageNum typeImg'><img src='" + _context + "/resources/pandora3/images/common_new/img_page_right_arrow2.png' alt=''></span></li>";
 }else{
	 pageInner+="<li class='rightOne'><a class='pageNum typeImg' href='javascript:nextPage(\""+ gridId +"\", "+ currentPage +");' title='다음 페이지로 이동'><img src='" + _context + "/resources/pandora3/images/common_new/img_page_right_arrow1.png' alt=''></a></li>";
	 pageInner+="<li class='rightTwo'><a class='pageNum typeImg' href='javascript:lastPage(\""+ gridId +"\", "+ totalPage +");' title='마지막 페이지로 이동'><img src='" + _context + "/resources/pandora3/images/common_new/img_page_right_arrow2.png' alt=''></a></li>";
 }


 var pageInfoText = "총 " + totalSize + "건";

 var table = "";
 table+= "<div class='pagination'>";
 table+= "<ul class='paging'>";
 table+= pageInner;
 table+= "</ul>";

 table+="<div class='pagingRight'>";
 table+="<select id='pagerNum_"+pagerId+"' name='' class='select' onchange='rowNumClick(\""+ gridId +"\", this)' >";

 for(var i in _grid_rows_list) {
	 table+="<option value='" + _grid_rows_list[i] + "'>"+ _grid_rows_list[i] +"</option>";
 }

 table+="</select>";
 table+= pagerYn ? "<span>" + pageInfoText + "</span> " : "" ;
 table+="</div>";
 table+= "</div>";



 // 페이징할 DIV태그에 우선 내용을 비우고 페이징 태그삽입
 $("#"+pagerId).html("");
 // 너비 조정
 var w = $('#'+gridId).width();
 $("#"+pagerId).width(w);
 // 페이징 html 추가
 $("#"+pagerId).append(table);
 // 페이징 클래스 추가
// $("#"+pagerId).addClass("customPaginateBar");
// console.log($('#'+gridId).getGridParam('rowNum'));
// $("#pagerNum").val($('#'+gridId).getGridParam('rowNum')).attr("selected", "selected");

 $("#pagerNum_" + pagerId + " option[value='" + $('#'+gridId).getGridParam('rowNum') + "']").prop("selected", true);

}

// 그리드 첫페이지로 이동
function firstPage(gridId){
 $("#"+gridId).jqGrid('setGridParam', { page:1 });
 var select = $('#'+gridId).jqGrid('getGridParam', 'select');
 eval(select());
}

// 그리드 이전페이지 이동
function prePage(gridId, currentPage){
// var currentPage = $("#"+gridId).getGridParam('page');

// currentPage-=pageCount;
// pageList=Math.ceil(currentPage/pageCount);
// currentPage=(pageList-1)*pageCount+pageCount;

 $("#"+gridId).jqGrid('setGridParam', { page:currentPage-1 });
 var select = $('#'+gridId).jqGrid('getGridParam', 'select');
 eval(select());
}

// 그리드 다음페이지 이동
function nextPage(gridId, currentPage){
// var currentPage = $("#"+gridId).getGridParam('page');

// currentPage+=pageCount;
// pageList=Math.ceil(currentPage/pageCount);
// currentPage=(pageList-1)*pageCount+1;

 $("#"+gridId).jqGrid('setGridParam', { page:currentPage+1 });
 var select = $('#'+gridId).jqGrid('getGridParam', 'select');
 eval(select());
}

// 그리드 마지막페이지 이동
function lastPage(gridId){
 var totalSize = $('#'+gridId).getGridParam('records');
 var totalPage = Math.ceil(totalSize/$('#'+gridId).getGridParam('rowNum'));

 $("#"+gridId).jqGrid('setGridParam', { page:totalPage });
 var select = $('#'+gridId).jqGrid('getGridParam', 'select');
 eval(select());
}

// 그리드 페이지 이동
function goPage(gridId, num){
 $("#"+gridId).jqGrid('setGridParam', { page:num });
 var select = $('#'+gridId).jqGrid('getGridParam', 'select');
 eval(select());
}

// 페이지 카운트 클릭 시 재 조회
function rowNumClick(gridId, obj){
	 $("#"+gridId).jqGrid('setGridParam', { page:1 });
	 $("#"+gridId).jqGrid('setGridParam', { rowNum:obj.value });
	 var select = $('#'+gridId).jqGrid('getGridParam', 'select');
	 eval(select());
};
//grid data json 변환
function getSaveData(grdId){
	var data={};
	var objGrid = $("#"+ grdId);
	var rows = $("#"+ grdId).getRowData();
	for(var i = 0; i < rows.length; i++) {
		objGrid.editCell(i, 0, false);
	}
	// 유효성 검사
	var rowIds = objGrid.getDataIDs();
	var cols = objGrid.jqGrid('getGridParam', 'colModel');
	for(var i = 0; i < rowIds.length; i++) {
		var row = objGrid.getRowData(rowIds[i]);
		if(row.JQGRIDCRUD == 'C' || row.JQGRIDCRUD == 'U') {
			// 필수값 체크
			for(var k = 0; k < cols.length; k++) {
				if(cols[k].required != undefined && cols[k].required) {
					var val = objGrid.getCell(rowIds[i], cols[k].name);
					if(val == '') {
						alert(cols[k].label+'(은)는 필수 입력항목입니다. 값을 입력해 주세요.');
							objGrid.editCell(parseInt(i+1, 10), k, true);
							return;
						}
				}
					// 임시값 입력
				if (cols[k].formatter == 'date' && !cols[k].editable) {
					objGrid.setCell(rowIds[i], cols[k].name, $.timestampToString(new Date()));
				}
			}
		}
	}
	// 삽입, 갱신할 데이터를 배열에 추가
	var saveList = []; // 삽입, 갱신할 열 배열
	for(var i = 0; i < rowIds.length; i++) {
		var row = objGrid.getRowData(rowIds[i]);
		//console.log(row);
		if(row.JQGRIDCRUD == 'C' || row.JQGRIDCRUD == 'U' || row.JQGRIDCRUD == 'D') {
			saveList.push(row);
		}
	}
	return JSON.stringify(saveList)
}

// th 필수값 강조
function highlight(gridId){
	var colmnsInfo = $('#'+gridId).jqGrid('getGridParam', 'colModel');

	for(var i = 0; i < colmnsInfo.length; i++) {
		var required = colmnsInfo[i].required;
		if(required != undefined && required!='undefined' && required==true){
		  var colNm =colmnsInfo[i].name;
		  $('#'+gridId+'_'+colNm+ " > div").addClass("highlight");
		}
	}
	$("#"+gridId+" > tbody").append("<tr><td class='search_blank' style='overflow:hidden; height:"+($("#"+gridId).closest(".ui-jqgrid-bdiv").height() - 17) + "px; line-height:"+$("#"+gridId).closest(".ui-jqgrid-bdiv").height()+"px' align='center' colspan='"+colmnsInfo.length+"'>검색 결과가 없습니다.</td></tr>");
}
