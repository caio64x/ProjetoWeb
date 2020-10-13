using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SalesWebMvc.Models.Enums
{
    public enum SalesStatus : int
    {
        //Pendente
        //Faturado
        //Cancelado
        Pending = 0,
        Billed = 1, 
        Canceled = 2
    }
}
