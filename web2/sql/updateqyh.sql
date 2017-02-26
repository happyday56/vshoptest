
-- 1207
ALTER VIEW [dbo].[vw_Hishop_BrowseProductListNoBuy]
AS
SELECT     p.CategoryId, p.TypeId, p.BrandId, p.ProductId, p.ProductName, p.ProductCode, p.ShortDescription, p.MarketPrice, p.ThumbnailUrl40, p.ThumbnailUrl60, p.ThumbnailUrl100, p.ThumbnailUrl160, 
                      p.ThumbnailUrl180, p.ThumbnailUrl220, p.ThumbnailUrl310, p.SaleStatus, p.DisplaySequence, p.MainCategoryPath, p.ExtendCategoryPath, p.SaleCounts, p.ShowSaleCounts, p.AddedDate, 
                      p.VistiCounts,
                          (SELECT     MIN(SalePrice) AS Expr1
                            FROM          dbo.Hishop_SKUs
                            WHERE      (ProductId = p.ProductId)) AS SalePrice,
                          (SELECT     TOP (1) SkuId
                            FROM          dbo.Hishop_SKUs AS Hishop_SKUs_3
                            WHERE      (ProductId = p.ProductId)
                            ORDER BY SalePrice) AS SkuId,
                          (SELECT     SUM(Stock) AS Expr1
                            FROM          dbo.Hishop_SKUs AS Hishop_SKUs_2
                            WHERE      (ProductId = p.ProductId)) AS Stock,
                          (SELECT     TOP (1) Weight
                            FROM          dbo.Hishop_SKUs AS Hishop_SKUs_1
                            WHERE      (ProductId = p.ProductId)
                            ORDER BY SalePrice) AS Weight,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.Taobao_Products
                            WHERE      (ProductId = p.ProductId)) AS IsMakeTaobao,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.Hishop_ProductReviews
                            WHERE      (ProductId = p.ProductId)) AS ReviewsCount, p.HomePicUrl, p.IsDisplayHome, p.AddUserId, p.VirtualPointRate, p.IsCross, p.MaxCross, category.Name AS CategoryName, 
                      type.TypeName, brand.BrandName, p.Unit
FROM         dbo.Hishop_Products AS p LEFT OUTER JOIN
                      dbo.Hishop_BrandCategories AS brand ON p.BrandId = brand.BrandId LEFT OUTER JOIN
                      dbo.Hishop_Categories AS category ON p.CategoryId = category.CategoryId LEFT OUTER JOIN
                      dbo.Hishop_ProductTypes AS type ON p.TypeId = type.TypeId

GO
ALTER VIEW [dbo].[vw_Hishop_SaleDetails]
AS
SELECT     oi.OrderId, s3.SKU, oi.ItemDescription AS ProductName, oi.Quantity, oi.ShipmentQuantity, oi.ItemAdjustedPrice, o.Amount, o.DiscountAmount, 
                      CASE WHEN o.RedPagerID <> 1 THEN o.RedPagerAmount ELSE 0 END AS RedPagerAmount, CASE WHEN o.RedPagerID = 1 THEN o.RedPagerAmount ELSE 0 END AS VirtualPointAmount, 
                      o.OrderTotal, o.OrderDate, o.PayDate, o.ShippingDate, o.FinishDate, o.OrderStatus, o.OrderType, 
                      CASE WHEN o.OrderType = 1 THEN '普通订单' WHEN o.OrderType = 2 THEN '开店订单' ELSE '' END AS OrderTypeName, oi.CostPrice, oi.ItemsCommission, oi.SecondItemsCommission, 
                      oi.ThirdItemsCommission, oi.ItemAdjustedCommssion, p.ProductCode,oi.ManagerItemCommission
FROM         dbo.Hishop_OrderItems AS oi LEFT OUTER JOIN
                      dbo.Hishop_Orders AS o ON oi.OrderId = o.OrderId
                       LEFT JOIN   Hishop_SKUs s3 ON s3.SkuId=oi.SkuId
                       LEFT JOIN Hishop_Products as p on s3.ProductId =p.ProductId

GO


ALTER VIEW [dbo].[vw_Hishop_SaleOrderStatisticsData]
AS
SELECT     o.OrderId, o.OrderDate, o.PayDate, o.ShippingDate, o.FinishDate, o.ReferralUserId AS StoreUserId, rd.StoreName, rm.UserName AS StoreUserName, rm.RealName AS StoreRealName, 
                      o.UserId AS MemberUserId, m.UserName AS MemberUserName, m.RealName AS MemberRealName, o.Amount, o.DiscountAmount, 
                      CASE WHEN o.RedPagerID <> 1 THEN o.RedPagerAmount ELSE 0 END AS RedPagerAmount, CASE WHEN o.RedPagerID = 1 THEN o.RedPagerAmount ELSE 0 END AS VirtualPointAmount, 
                      o.StoreGiftMoney, o.MemberGiftMoney, o.OrderTotal, o.OrderType, CASE WHEN o.OrderType = 1 THEN '普通订单' WHEN o.OrderType = 2 THEN '开店订单' ELSE '' END AS OrderTypeName, 
                      o.OrderStatus, 
                      CASE WHEN o.OrderStatus = 1 THEN '待付款' WHEN o.OrderStatus = 2 THEN '待发货' WHEN o.OrderStatus = 3 THEN '已发货' WHEN o.OrderStatus = 4 THEN '已关闭' WHEN o.OrderStatus = 5 THEN
                       '订单已完成' WHEN o.OrderStatus = 6 THEN '申请退款' WHEN o.OrderStatus = 7 THEN '申请退货' WHEN o.OrderStatus = 8 THEN '申请换货' WHEN o.OrderStatus = 9 THEN '已退款' WHEN o.OrderStatus
                       = 10 THEN '已退货' ELSE '历史订单' END AS OrderStatusName, o.FirstCommission, o.SecondCommission, o.ThirdCommission, o.OrderCostPrice,o.ManagerCommission
FROM         dbo.Hishop_Orders AS o LEFT OUTER JOIN
                      dbo.aspnet_Distributors AS rd ON o.ReferralUserId = rd.UserId LEFT OUTER JOIN
                      dbo.aspnet_Members AS rm ON o.ReferralUserId = rm.UserId LEFT OUTER JOIN
                      dbo.aspnet_Members AS m ON o.UserId = m.UserId

GO

--12.20
alter table Hishop_Products add ProductFeature varchar(20)
go
update Hishop_Products set ProductFeature='Normal'
go
alter table Hishop_Products add StartTime datetime;
go
alter table Hishop_Products add EndTime datetime;
go

--1.20
CREATE TABLE [dbo].[Hishop_ProductsToCategory](
	[CategoryId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
 CONSTRAINT [PK_Hishop_ProductsToCategory] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

insert Hishop_ProductsToCategory (CategoryId,ProductId) select CategoryId,ProductId from Hishop_Products where CategoryId>0
go


CREATE VIEW [dbo].[vw_Hishop_BrowseProductListNoBuyCategory]
AS
SELECT     p.CategoryId, p.TypeId, p.BrandId, p.ProductId, p.ProductName, p.ProductCode, p.ShortDescription, p.MarketPrice, p.ThumbnailUrl40, p.ThumbnailUrl60, 
                      p.ThumbnailUrl100, p.ThumbnailUrl160, p.ThumbnailUrl180, p.ThumbnailUrl220, p.ThumbnailUrl310, p.SaleStatus, p.DisplaySequence, p.SaleCounts, 
                      p.ShowSaleCounts, p.AddedDate, p.VistiCounts,
                          (SELECT     MIN(SalePrice) AS Expr1
                            FROM          dbo.Hishop_SKUs
                            WHERE      (ProductId = p.ProductId)) AS SalePrice,
                          (SELECT     TOP (1) SkuId
                            FROM          dbo.Hishop_SKUs AS Hishop_SKUs_3
                            WHERE      (ProductId = p.ProductId)
                            ORDER BY SalePrice) AS SkuId,
                          (SELECT     SUM(Stock) AS Expr1
                            FROM          dbo.Hishop_SKUs AS Hishop_SKUs_2
                            WHERE      (ProductId = p.ProductId)) AS Stock,
                          (SELECT     TOP (1) Weight
                            FROM          dbo.Hishop_SKUs AS Hishop_SKUs_1
                            WHERE      (ProductId = p.ProductId)
                            ORDER BY SalePrice) AS Weight,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.Taobao_Products
                            WHERE      (ProductId = p.ProductId)) AS IsMakeTaobao,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.Hishop_ProductReviews
                            WHERE      (ProductId = p.ProductId)) AS ReviewsCount, p.HomePicUrl, p.IsDisplayHome, p.AddUserId, p.VirtualPointRate, p.IsCross, p.MaxCross, 
                      category.Name AS CategoryName, type.TypeName, brand.BrandName, p.Unit, category.Path
FROM         dbo.Hishop_ProductsToCategory AS pc LEFT OUTER JOIN
                      dbo.Hishop_Products AS p ON p.ProductId = pc.ProductId LEFT OUTER JOIN
                      dbo.Hishop_BrandCategories AS brand ON p.BrandId = brand.BrandId LEFT OUTER JOIN
                      dbo.Hishop_Categories AS category ON pc.CategoryId = category.CategoryId LEFT OUTER JOIN
                      dbo.Hishop_ProductTypes AS type ON p.TypeId = type.TypeId

GO

CREATE VIEW [dbo].[vw_Hishop_BrowseProductListCategory]
AS
SELECT     pc.CategoryId, p.TypeId, p.BrandId, pc.ProductId, p.ProductName, p.ProductCode, p.ShortDescription, p.MarketPrice, p.ThumbnailUrl40, p.ThumbnailUrl60, 
                      p.ThumbnailUrl100, p.ThumbnailUrl160, p.ThumbnailUrl180, p.ThumbnailUrl220, p.ThumbnailUrl310, p.SaleStatus, p.DisplaySequence, p.SaleCounts, 
                      p.ShowSaleCounts, p.AddedDate, p.VistiCounts,
                          (SELECT     MIN(SalePrice) AS Expr1
                            FROM          dbo.Hishop_SKUs
                            WHERE      (ProductId = p.ProductId)) AS SalePrice,
                          (SELECT     TOP (1) SkuId
                            FROM          dbo.Hishop_SKUs AS Hishop_SKUs_3
                            WHERE      (ProductId = p.ProductId)
                            ORDER BY SalePrice) AS SkuId,
                          (SELECT     SUM(Stock) AS Expr1
                            FROM          dbo.Hishop_SKUs AS Hishop_SKUs_2
                            WHERE      (ProductId = p.ProductId)) AS Stock,
                          (SELECT     TOP (1) Weight
                            FROM          dbo.Hishop_SKUs AS Hishop_SKUs_1
                            WHERE      (ProductId = p.ProductId)
                            ORDER BY SalePrice) AS Weight,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.Taobao_Products
                            WHERE      (ProductId = p.ProductId)) AS IsMakeTaobao,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.Hishop_ProductReviews
                            WHERE      (ProductId = p.ProductId)) AS ReviewsCount, p.HomePicUrl, p.IsDisplayHome, p.AddUserId, p.VirtualPointRate, p.IsCross, p.MaxCross, c.Path
FROM         dbo.Hishop_ProductsToCategory AS pc LEFT OUTER JOIN
                      dbo.Hishop_Products AS p ON p.ProductId = pc.ProductId LEFT OUTER JOIN
                      dbo.Hishop_Categories AS c ON pc.CategoryId = c.CategoryId
WHERE     (p.IsDistributorBuy = 0)

GO

--
--SiteSettings.config 添加 SiteNote节点

--2017.2.4
Create FUNCTION [dbo].[GetCommissionRemoveVirtualPoint]
(
	@UserId INT,
	@SkuId NVARCHAR(100),
	@VirtualPointRate decimal(18,2)
)
RETURNS Money
AS
BEGIN
	
	
	DECLARE @CommPrice Money;
	DECLARE @ProfitRise MONEY;
	
	SET @CommPrice = 0;
	
	IF(@UserId > 0 AND len(isnull(@SkuId,'')) > 0)
	BEGIN
		--SELECT s.SalePrice - s.CostPrice,* FROM Hishop_SKUs s
		SELECT TOP  1 @ProfitRise = s.SalePrice*(1-@VirtualPointRate) - s.CostPrice
		  FROM Hishop_SKUs s WHERE s.SkuId = @SkuId;
		
		IF (isnull(@ProfitRise,0) = 0) RETURN @CommPrice;
		
		SELECT TOP 1 @CommPrice = 
		CASE d.GradeId 
			WHEN 1 THEN @ProfitRise * (FirstCommissionRise / 100)
			WHEN 2 THEN @ProfitRise * (FirstCommissionRise / 100)
			WHEN 3 THEN @ProfitRise * (FirstCommissionRise / 100)
		ELSE 0 END
		FROM aspnet_Distributors d INNER JOIN aspnet_DistributorGrade dg 
		ON d.DistributorGradeId = dg.GradeId
		
		
	END
	
	RETURN @CommPrice;

END


--2017 2 26
alter table Hishop_Products add LimitBuy int;
go
alter table Hishop_Products add LimitBuyNums int;
go
update Hishop_Products set LimitBuy=0,LimitBuyNums=0;
go

