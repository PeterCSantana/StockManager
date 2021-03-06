﻿using StockPortfolioManager.Data.Context;
using StockPortfolioManager.Domain.Interface.Repository;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;

namespace StockPortfolioManager.Data.Repository
{
  public class RepositoryBase<T> : IRepositoryBase<T> where T : class
  {
    public virtual void Add(params T[] items)
    {
      using (StockPortfolioManagerContext context = new StockPortfolioManagerContext())
      {
        foreach (T item in items)
        {
          context.Entry(item).State = EntityState.Added;
        }
        context.SaveChanges();
      }
    }

    public virtual void AddNoValidate(params T[] items)
    {
      using (StockPortfolioManagerContext context = new StockPortfolioManagerContext())
      {
        foreach (T item in items)
        {
          context.Entry(item).State = EntityState.Added;
        }
        context.SaveChanges();
      }
    }

    public virtual void Delete(params T[] items)
    {
      using (StockPortfolioManagerContext context = new StockPortfolioManagerContext())
      {
        foreach (T item in items)
        {
          context.Entry(item).State = EntityState.Deleted;
        }
        context.SaveChanges();
      }
    }

    public virtual void Dispose()
    {
      GC.SuppressFinalize(this);
    }

    public virtual IList<T> GetAll(params Expression<Func<T, object>>[] navProperties)
    {
      List<T> list;
      using (StockPortfolioManagerContext context = new StockPortfolioManagerContext())
      {
        IQueryable<T> dbQuery = context.Set<T>();

        if (navProperties != null)
        {
          dbQuery = navProperties.Aggregate(dbQuery, (current, include) => current.Include(include));
        }

        foreach (Expression<Func<T, object>> navigationProperty in navProperties)
        {
          dbQuery = dbQuery.Include<T, object>(navigationProperty);
        }

        list = dbQuery.AsNoTracking().ToList<T>();
      }

      return list;
    }

    public virtual IList<T> GetList(Func<T, bool> where, params Expression<Func<T, object>>[] navProperties)
    {
      List<T> list;
      using (StockPortfolioManagerContext context = new StockPortfolioManagerContext())
      {
        IQueryable<T> dbQuery = context.Set<T>();

        foreach (Expression<Func<T, object>> navigationProperty in navProperties)
        {
          dbQuery = dbQuery.Include<T, object>(navigationProperty);
        }

        list = dbQuery.AsNoTracking().Where(where).AsQueryable<T>().ToList<T>();
      }

      return list;
    }

    public IList<T> GetList(Func<T, bool> where, out int TotalPages, int pageIndex = 0, int pageSize = 20, params Expression<Func<T, object>>[] navProperties)
    {
      List<T> list;
      using (StockPortfolioManagerContext context = new StockPortfolioManagerContext())
      {
        IQueryable<T> dbQuery = context.Set<T>();

        foreach (Expression<Func<T, object>> navigationProperty in navProperties)
        {
          dbQuery = dbQuery.Include<T, object>(navigationProperty);
        }

        dbQuery = dbQuery.AsNoTracking().Where(where).AsQueryable<T>().Paged<T>(pageIndex, pageSize, out TotalPages);

        list = dbQuery.ToList<T>();
      }
      return list;
    }

    public virtual T GetSingle(Func<T, bool> where, params Expression<Func<T, object>>[] navProperties)
    {
      T item = null;
      using (StockPortfolioManagerContext context = new StockPortfolioManagerContext())
      {
        IQueryable<T> dbQuery = context.Set<T>();

        foreach (Expression<Func<T, object>> navigationProperty in navProperties)
        {
          dbQuery = dbQuery.Include<T, object>(navigationProperty);
        }

        item = dbQuery.AsNoTracking().FirstOrDefault(where);
      }

      return item;
    }

    public virtual void Update(params T[] items)
    {
      using (StockPortfolioManagerContext context = new StockPortfolioManagerContext())
      {
        foreach (T item in items)
        {
          context.Entry(item).State = EntityState.Modified;
        }
        context.SaveChanges();
      }
    }

    public virtual void UpdateNoValidate(params T[] items)
    {
      using (StockPortfolioManagerContext context = new StockPortfolioManagerContext())
      {
        foreach (T item in items)
        {
          context.Entry(item).State = EntityState.Modified;
        }
        context.SaveChanges();
      }
    }
  }
}
