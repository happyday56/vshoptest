﻿

$(function () {
    $.each($(".SKUValueClass"), function () { $(this).bind("click", function () { SelectSkus(this); }); });
    $("#buyButton").bind("click", function () { BuyProduct(); }); //立即购买
    $("#spAdd").bind("click", function () { $("#buyNum").val(parseInt($("#buyNum").val()) + 1) });
    $("#spSub").bind("click", function () { var num = parseInt($("#buyNum").val()) - 1; if (num > 0) $("#buyNum").val(parseInt($("#buyNum").val()) - 1) });
    $("#spcloces").bind("click", function () { $("#divshow").hide() });
});
function disableShoppingBtn(disabled) {//禁用(启用)购买和加入购物车按钮

    var btns = $('button[type=shoppingBtn]');
    if (disabled)
        btns.addClass('disabled');
    else
        btns.removeClass('disabled');
}

function SelectSkus(clt) {
    //禁用购买和加入购物车按钮
    disableShoppingBtn(true);

    // 保存当前选择的规格
    var AttributeId = $(clt).attr("AttributeId");
    var ValueId = $(clt).attr("ValueId");
    $("#skuContent_" + AttributeId).val(AttributeId + ":" + ValueId);
    // 重置样式
    ResetSkuRowClass("skuRow_" + AttributeId, "skuValueId_" + AttributeId + "_" + ValueId);
    // 如果全选，则重置SKU
    var allSelected = IsallSelected();
    var selectedOptions = "";
    if (allSelected) {
        $.each($("input[type='hidden'][name='skuCountname']"), function () {
            selectedOptions += $(this).attr("value") + ",";
        });
        selectedOptions = selectedOptions.substring(0, selectedOptions.length - 1);
        $.ajax({
            url: "/API/VshopProcess.ashx",
            type: 'post', dataType: 'json', timeout: 10000,
            data: { action: "GetSkuByOptions", productId: $("#hiddenProductId").val(), options: selectedOptions },
            success: function (resultData) {
                if (resultData.Status == "OK") {
                    ResetCurrentSku(resultData.SkuId, resultData.SKU, resultData.Weight, resultData.Stock, resultData.SalePrice);
                }
                else {
                    ResetCurrentSku("", "", "", "", "0"); //带服务端返回的结果，函数里可以根据这个结果来显示不同的信息
                }
                disableShoppingBtn(false); //启用购买和加入购物车按钮
            },
            error: function () {
                disableShoppingBtn(false); //启用购买和加入购物车按钮
            }
        });
    }
}

// 是否所有规格都已选
function IsallSelected() {
    var allSelected = true;
    $.each($("input[type='hidden'][name='skuCountname']"), function () {
        if ($(this).val().length == 0) {
            allSelected = false;
        }
    });
    return allSelected;
}

// 重置规格值的样式
function ResetSkuRowClass(skuRowId, skuSelectId) {
    var pvid = skuSelectId.split("_");

    $.each($("#" + skuRowId + " div"), function () {
        $(this).removeClass('active');
    });

    $("#" + skuSelectId).addClass('active');
}

// 重置SKU

function ResetCurrentSku(skuId, sku, weight, stock, salePrice) {
    $("#hiddenSkuId").val(skuId);
    $(".spSalaPrice").html(salePrice);
    if (!isNaN(parseInt(stock))) {
        $("#spStock").html(stock);
    }
    else {
        $("#spStock").html("0");
        alert_h("该规格的产品没有库存，请选择其它的规格！");
    }
}

// 购买按钮单击事件
function BuyProduct() {
    if (!ValidateBuyAmount())
    {
        return false;
    }

    if (!IsallSelected()) {
        //debugger;
        alert_h("请选择规格");
        return false;
    }

    var quantity = parseInt($("#buyNum").val());
    var stock = parseInt($("#spStock").html());
    var maxCross = parseInt($("#maxCross").html());
    var isBuy = parseInt($("#isBuy").html());
    var isPdBuy = parseInt($("#isPdBuy").html());
    
    if (isNaN(stock) || stock == 0) {
        alert_h("该规格的产品没有库存，请选择其它的规格！");
        return false;
    }

    if (quantity > stock) {
        alert_h("商品库存不足 " + quantity + " 件，请修改购买数量!");
        return false;
    }

    if (isBuy > 0) {
        alert_h("您已购买过此商品，不能再次购买，请重新选择其他商品!");
        return false;
    }

    if (isPdBuy >= maxCross) {
        alert_h("此商品已在您的购物车达到最大购买数量 " + maxCross + " 件，请修改购买数量!");
        return false;
    }
    
    if (quantity > maxCross) {
        alert_h("此商品最多只能购买 " + maxCross + " 件，请修改购买数量!");
        return false;
    }

    //location.href = "/Vshop/UserLogin.aspx?userstatus=1&buyAmount=" + $("#buyNum").val() + "&productSku=" + $("#hiddenSkuId").val() + "&from=signBuy";
    location.href = "/vshop/submmitOrder.aspx?buyAmount=" + $("#buyNum").val() + "&productSku=" + $("#hiddenSkuId").val() + "&from=signBuy";
}

// 验证数量输入
function ValidateBuyAmount() {
    var buyNum = $("#buyNum");
    if ($(buyNum).val().length == 0) {
        alert_h("请先填写购买数量!");
        return false;
    }
    if ($(buyNum).val() == "0" || $(buyNum).val().length > 5) {

        alert_h("填写的购买数量必须大于0小于99999!");
        var str = $(buyNum).val();
        $(buyNum).val(str.substring(0, 5));
        return;
    }
    var amountReg = /^[1-9]d*|0$/;
    if (!amountReg.test($(buyNum).val())) {
        alert_h("请填写正确的购买数量!");
        return false;
    }

    return true;
}

function AddProductToCart() {
    if (!ValidateBuyAmount()) {
        return false;
    }

    if (!IsallSelected()) {
        alert_h("请选择规格");
        return false;
    }
    var quantity = parseInt($("#buyNum").val());
    var stock = parseInt($("#spStock").html());
    var maxCross = parseInt($("#maxCross").html());
    var isBuy = parseInt($("#isBuy").html());
    var isPdBuy = parseInt($("#isPdBuy").html());
    var skuId = $("#hiddenSkuId").val();

    if (isNaN(stock) || stock == 0) {
        alert_h("该规格的产品没有库存，请选择其它的规格！");
        return false;
    }
    if (quantity > stock) {
        alert_h("商品库存不足 " + quantity + " 件，请修改购买数量!");
        return false;
    }

    if (isBuy > 0) {
        alert_h("您已购买过此商品，不能再次购买，请重新选择其他商品!");
        return false;
    }

    if (isPdBuy >= maxCross) {
        alert_h("此商品已在您的购物车达到最大购买数量 " + maxCross + " 件，请修改购买数量!");
        return false;
    }

    if (quantity > maxCross) {
        alert_h("此商品最多只能购买 " + maxCross + " 件，请修改购买数量!");
        return false;
    }

    BuyProductToCart();//添加到购物车
}

function BuyProductToCart() {
    $.ajax({
        url: "/API/VshopProcess.ashx",
        type: 'post', dataType: 'json', timeout: 10000,
        data: { action: "AddToCartBySkus", quantity: parseInt($("#buyNum").val()), productSkuId: $("#hiddenSkuId").val(), productId: $("#vProductDetails_litproductid").val(), categoryid: $("#vProductDetails_litCategoryId").val() },
        async: false,
        success: function (resultData) {

            if (resultData.Status == "OK") {
                var xtarget = $("#addcartButton").offset().left;
                var ytarget = $("#addcartButton").offset().top;

                $("#divshow").css("top", "200px");
                $("#divshow").css("left", parseInt(xtarget) + "px");
                myConfirm('添加成功', '商品已经添加至购物车', '现在去购物车', function () {
                    location.replace('/Vshop/ShoppingCart.aspx');
                });
                //显示添加购物成功
            } else if (resultData.Status == "0") {
                // 商品已经下架

                alert_h("此商品已经不存在(可能被删除或被下架)，暂时不能购买");
            }
            else if (resultData.Status == "1") {
                // 商品库存不足

                alert_h("商品库存不足 " + parseInt($("#buyNum").val()) + " 件，请修改购买数量!");
            }
            else if (resultData.Status == "3") {
                alert_h("此商品最多只能购买 " + resultData.rnt + " 件，请修改购买数量!");
            }
            else if (resultData.Status == "5") {
                alert_h("此商品已存在同类型的购买，不能再次购买，请选择其他的商品，谢谢！");
            }
            else {
                if (resultData.Status == "2") {
                    location.href = "/Vshop/UserLogin.aspx?userstatus=0&productid=" + $("#vProductDetails_litproductid").val() + "";
                }
                else {
                    // 抛出异常消息

                    alert_h(resultData.Status + '66');
                }
            }
        }
    });
}

var seckillData = {status:0,toStartTime:0,startTime:0,endTime:0};
var SecKill = {};
SecKill.init= function(){
    if($("#btnProductFeature").val()=="Seckill")
    {
        seckillData.status = $("#btnSeckillStatus").val(); //0未开始，1开始，2结束
        seckillData.toStartTime = $("#btnSeckillToStartTime").val();
        seckillData.endTime = $("#btnSeckillEndTime").val();
        seckillData.startTime = $("#btnSeckillStartTime").val();
        if (seckillData.status == 0) {

        } else {

        }

        $("#divSeckill").show();
    }
}

SecKill.init();
