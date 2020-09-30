using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SalesWebMvc.Models
{
    public class Department //departamento
    {
        public int ID { get; set; } //id do departamento
        public string Name { get; set; } //nome do departamento
        public ICollection<Seller> Sellers { get; set; } = new List<Seller>(); //associação para muitos

        public Department()
        {
        }

        public Department(int iD, string name)
        {
            ID = iD;
            Name = name;
        }

        public void AddSeller(Seller seller)
        {
            Sellers.Add(seller);
        }

        public double TotalSalles(DateTime initial, DateTime final)
        {
            return Sellers.Sum(Seller => Seller.TotalSales(initial, final));
        }
    }
}
