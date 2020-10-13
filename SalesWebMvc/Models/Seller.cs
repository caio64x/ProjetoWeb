using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SalesWebMvc.Models
{
    public class Seller //vendedor
    {
        public int Id { get; set; } //id do vendedor
        public string Name { get; set; } //Nome do vendedor
        public string Email { get; set; } //Email do vendedor
        public DateTime BirthDate { get; set; } //Data de aniversario do vendedor
        public double BaseSalary { get; set; } //base de salario do vendedor
        public Department Department { get; set; } //associação unica
        public ICollection<SalesRecord> Sales { get; set; } = new List<SalesRecord>(); //associação para muitos

        public Seller()
        {
        }

        public Seller(string name, string email, DateTime birthDate, double baseSalary, Department department)
        {

            Name = name;
            Email = email;
            BirthDate = birthDate;
            BaseSalary = baseSalary;
            Department = department;
        }

        public void AddSales(SalesRecord sr)
        {
            Sales.Add(sr);
        }


        public void removeSales(SalesRecord sr)
        {
            Sales.Remove(sr);
        }

        public double TotalSales(DateTime initial, DateTime final)
        {
            return Sales.Where(sr => sr.Date >= initial && sr.Date <= final).Sum(sr => sr.Amount);
        }
    }
}
