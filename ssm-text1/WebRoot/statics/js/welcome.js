$(".tou").click(function() {
	alert("1");
	$("#The_receiver").hide();
	$("#Write_letters").hide();
	$("#Letter").hide();
})
$("#xiexin").click(function() {
	$("#The_receiver").slideUp();
	$("#Letter").slideUp();
	$("#Write_letters").slideDown();
})
$("#shouxin").click(function() {
	$("#Letter").slideUp();
	$("#Write_letters").slideUp();
	$("#The_receiver").slideDown();
	//$(".meilSender").html("收信人");
})
$("#faxin").click(function() {
	$("#The_receiver").slideUp();
	$("#Write_letters").slideUp();
	$("#Letter").slideDown();
	//$(".meilSender").html("发信人");
})
/*$(".ameil_weidu").hover(
	function() {
		var index = $(".ameil_weidu").index(this);
		$(this).css("background-color", "gray");
		$(this).css("color", "red");
		$(this).css("cursor", "pointer");
	},
	function() {
		var index = $(".ameil_weidu").index(this);
		$(this).css("background-color", "white");
		$(this).css("cursor", "default");
		$(this).css("color", "black");
	}
)
$(".ameil_yidu").hover(
	function() {
		var index = $(".ameil_yidu").index(this);
		$(this).css("background-color", "gray");
		$(this).css("color", "red");
		$(this).css("cursor", "pointer");
	},
	function() {
		var index = $(".ameil_yidu").index(this);
		$(this).css("background-color", "white");
		$(this).css("cursor", "default");
		$(this).css("color", "black");
	}
)*/
