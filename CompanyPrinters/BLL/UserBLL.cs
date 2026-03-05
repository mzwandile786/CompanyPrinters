using System.Data;
using CompanyPrinters.DAL;

namespace CompanyPrinters.BLL
{
    public class UserBLL
    {
        DALclass dal = new DALclass();

        public DataTable GetUsers()
        {
            return dal.GetUsers();
        }

        public void InsertUser(string firstName, string lastName, string email,
                               string username, string password, int designationId)
        {
            dal.InsertUser(firstName, lastName, email, username, password, designationId);
        }

        public void EditUser(int userId, string firstName, string lastName,
                             string email, string username, string password,
                             int designationId)
        {
            dal.EditUser(userId, firstName, lastName, email, username, password, designationId);
        }

        public void DeleteUser(int userId)
        {
            dal.DeleteUser(userId);
        }

        /* public DataTable GetUsersByDesignation(int? designationId)
         {
             return dal.SearchUsersByDesignation(designationId);
         }*/
        public DataTable GetUsersByDesignation(int? designationId)
        {
            DataTable dt = GetUsers(); // your GetUsers() returns UserID, DesignationID, etc.

            if (designationId.HasValue && designationId.Value > 0)
            {
                DataView dv = dt.DefaultView;
                dv.RowFilter = "DesignationID = " + designationId.Value;
                return dv.ToTable();
            }

            return dt;
        }


        // Checking if Username Exist
        public bool UsernameExists(string username, int? userId)
        {
            return dal.UsernameExists(username, userId);
        }

    }
}
