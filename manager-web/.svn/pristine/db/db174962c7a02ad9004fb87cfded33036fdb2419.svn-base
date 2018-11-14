<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
	changePageStyle("${curUrl}");
	//按照规则改变效果
	function changePageStyle(url) {
		$("a[href='${ctp}/" + url + "']").css("color", "red");
		//加上tree close样式
		$("a[href='${ctp}/" + url + "']").parents(".list-group-item")
				.removeClass("tree-closed");
		$("a[href='${ctp}/" + url + "']").parent().parent("ul").show(100);
	}
	function checkall_reverse(check_all_btn,check_btn){
		check_all_btn.click(function(){
			//如果是原生的属性，使用prop获取比较好
			check_btn.prop("checked",$(this).prop("checked"))
		});
		check_btn.click(function(){
			//当check_btn点满以后check_all_btn勾上，否则不选中
			//获取被选中的checkbtn个数
			var flag = check_btn.filter(":checked").length == check_btn.length;
			check_all_btn.prop("checked",flag);
		});
	}
</script>

