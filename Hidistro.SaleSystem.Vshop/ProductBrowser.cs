﻿namespace Hidistro.SaleSystem.Vshop
{
    using Hidistro.Core;
    using Hidistro.Core.Entities;
    using Hidistro.Entities.Comments;
    using Hidistro.Entities.Commodities;
    using Hidistro.Entities.Members;
    using Hidistro.SqlDal.Comments;
    using Hidistro.SqlDal.Commodities;
    using Hidistro.SqlDal.Members;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Runtime.InteropServices;

    public static class ProductBrowser
    {
        public static bool AddProductToFavorite(int productId, int userId)
        {
            FavoriteDao dao = new FavoriteDao();
            return (dao.ExistsProduct(productId, userId) || dao.AddProductToFavorite(productId, userId));
        }

        public static bool CheckHasCollect(int memberId, int productId)
        {
            return new FavoriteDao().CheckHasCollect(memberId, productId);
        }

        public static int DeleteFavorite(int favoriteId)
        {
            return new FavoriteDao().DeleteFavorite(favoriteId);
        }

        public static bool DeleteFavorites(string ids)
        {
            return new FavoriteDao().DeleteFavorites(ids);
        }

        public static bool ExistsProduct(int productId, int userId)
        {
            return new FavoriteDao().ExistsProduct(productId, userId);
        }

        public static DataTable GetActiviOne(int ActivitiesType, decimal MeetMoney)
        {
            return new ProductBrowseDao().GetActiviOne(ActivitiesType, MeetMoney);
        }

        public static DataTable GetActivitie(int ActivitiesId)
        {
            return new ProductBrowseDao().GetActivitie(ActivitiesId);
        }

        public static DataTable GetAllFull()
        {
            return new HomeProductDao().GetAllFull();
        }

        public static DataTable GetAllFull(int ActivitiesType, int UserId = -1)
        {
            if (UserId > -1)
                return new ProductBrowseDao().GetAllFull(ActivitiesType, UserId);
            else
                return new ProductBrowseDao().GetAllFull(ActivitiesType);
        }

        public static DataTable GetAllFullByCategoryId(int categoryId, int UserId = -1)
        {
            return new ProductBrowseDao().GetAllFullByCategoryId(categoryId);
        }

        public static DataTable GetAllFullBySubmitOrder(int ActivitiesType, int UserId = -1)
        {
            if (UserId > -1)
                return new ProductBrowseDao().GetAllFullBySubmitOrder(ActivitiesType, UserId);
            else
                return new ProductBrowseDao().GetAllFullBySubmitOrder(ActivitiesType);
        }

        public static DataTable GetBrandProducts(MemberInfo member, int? brandId, int pageNumber, int maxNum, out int total)
        {
            return new ProductBrowseDao().GetBrandProducts(member, brandId, pageNumber, maxNum, out total);
        }

        public static DataTable GetExpandAttributes(int productId)
        {
            return new SkuDao().GetExpandAttributes(productId);
        }

        public static DataTable GetFavorites(MemberInfo member)
        {
            return new FavoriteDao().GetFavorites(member);
        }

        public static DbQueryResult GetHomeProduct(MemberInfo member, ProductQuery query)
        {
            DistributorsInfo currentDistributors = DistributorsBrower.GetCurrentDistributors();
            if ((currentDistributors != null) && (currentDistributors.UserId != 0))
            {
                return new HomeProductDao().GetHomeProducts(member, query, true);
            }
            return new HomeProductDao().GetHomeProducts(member, query, false);
        }

        public static ProductInfo GetProduct(MemberInfo member, int productId)
        {
            return new ProductBrowseDao().GetProduct(member, productId);
        }

        public static DataTable GetProductCategories(int prouctId)
        {
            return new ProductDao().GetProductCategories(prouctId);
        }

        public static DbQueryResult GetProductConsultations(ProductConsultationAndReplyQuery consultationQuery)
        {
            return new ProductConsultationDao().GetConsultationProducts(consultationQuery);
        }

        public static int GetProductConsultationsCount(int productId, bool includeUnReplied)
        {
            return new ProductConsultationDao().GetProductConsultationsCount(productId, includeUnReplied);
        }

        public static DbQueryResult GetProductReviews(ProductReviewQuery reviewQuery)
        {
            return new ProductReviewDao().GetProductReviews(reviewQuery);
        }

        public static int GetProductReviewsCount(int productId)
        {
            return new ProductReviewDao().GetProductReviewsCount(productId);
        }

        public static DataTable GetProducts(MemberInfo member, int? topicId, int? categoryId, string keyWord, int pageNumber, int maxNum, out int total, string sort, string order)
        {
            return new ProductBrowseDao().GetProducts(member, topicId, categoryId, Globals.GetCurrentDistributorId(), keyWord, pageNumber, maxNum, out total, sort, order == "asc");
        }

        public static DataTable GetProductsByDisplayHome(MemberInfo member, int? topicId, int? categoryId, string keyWord, int pageNumber, int maxNum, out int total, string sort, string order)
        {
            return new ProductBrowseDao().GetProductsByDisplayHome(member, topicId, categoryId, Globals.GetCurrentDistributorId(), keyWord, pageNumber, maxNum, out total, sort, order == "asc");
            //return new ProductBrowseDao().GetProductsByDisplayHome(member, topicId, categoryId, -1, keyWord, pageNumber, maxNum, out total, sort, order == "asc");
        }

        public static DataTable GetProducts(MemberInfo member, int? topicId, int? categoryId, string keyWord, int pageNumber, int maxNum, out int total, string sort, string order, bool isselect)
        {
            DataTable table = new DataTable();
            int toal = 0;
            int currentDistributorId = Globals.GetCurrentDistributorId();
            if (currentDistributorId > 0)
            {
                table = new ProductBrowseDao().GetProducts(member, topicId, categoryId, currentDistributorId, keyWord, pageNumber, maxNum, out toal, sort, order == "asc", isselect);
            }
            total = toal;
            return table;
        }

        public static DataTable GetSkus(int productId)
        {
            return new SkuDao().GetSkus(productId);
        }

        public static DataTable GetTopicProducts(MemberInfo member, int topicid, int maxNum)
        {
            return new ProductBrowseDao().GetTopicProducts(member, topicid, maxNum);
        }

        public new static DataTable GetType()
        {
            return new ProductBrowseDao().GetType();
        }

        public static bool InsertProductConsultation(ProductConsultationInfo productConsultation)
        {
            return new ProductConsultationDao().InsertProductConsultation(productConsultation);
        }

        public static bool InsertProductReview(ProductReviewInfo review)
        {
            return new ProductReviewDao().InsertProductReview(review);
        }

        public static void LoadProductReview(int productId, int userId, out int buyNum, out int reviewNum)
        {
            new ProductReviewDao().LoadProductReview(productId, userId, out buyNum, out reviewNum);
        }

        public static int UpdateFavorite(int favoriteId, string tags, string remark)
        {
            return new FavoriteDao().UpdateFavorite(favoriteId, tags, remark);
        }

        public static bool UpdateVisitCounts(int productId)
        {
            return new ProductBatchDao().UpdateVisitCounts(productId);
        }

        public static ProductInfo GetProductLetterInfo(int productId)
        {
            return new ProductDao().GetProductLetterInfo(productId);
        }

        public static IList<ProductInfo> GetAllProductsByCond(int userId, bool isSearchToday)
        {
            return new ProductDao().GetAllProductsByCond(userId, isSearchToday);
        }

        public static int CheckTodayIsBuy(int productId, int userId, int diffDay)
        {
            return new ProductBrowseDao().CheckTodayIsBuy(productId, userId, diffDay);
        }

        public static int CheckProductIsBuy(int productId, int userId, int diffDay)
        {
            return new ProductBrowseDao().CheckProductIsBuy(productId, userId, diffDay);
        }

        public static int CheckProductSkuIsBuy(int productId, int userId, string skuId)
        {
            return new ProductBrowseDao().CheckProductSkuIsBuy(productId, userId, skuId);
        }
    }
}

