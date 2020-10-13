using Remotion.Linq.Clauses;
using SalesWebMvc.Models.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SalesWebMvc.Models
{
    public class SalesRecord //registro de venda
    {
        public int Id { get; set; } //id do registro de venda
        public DateTime Date { get; set; } //date
        public double Amount { get; set; } //montante
        public SalesStatus Status { get; set; } //status da venda
        public  Seller Seller { get; set; } //associação unica 

        public SalesRecord()
        {
        }

        public SalesRecord(DateTime date, double amount, SalesStatus status, Seller seller)
        {

            Date = date;
            Amount = amount;
            Status = status;
            Seller = seller;
        }
    }
}
