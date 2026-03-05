using System;
using System.Data;
using System.Data.SqlClient;
using CompanyPrinters.DAL;

namespace CompanyPrinters.BLL
{
    public class DesignationBLL
    {
        DALclass dal = new DALclass();
        DesignationDAL Dedal = new DesignationDAL();

        public DataTable GetDesignations()
        {
            return dal.GetDesignations();
        }

        public DataTable GetUsersByDesignation(int? designationId)
        {
            return dal.SearchUsersByDesignation(designationId);
        }
        public void AddDesignation(string designationName)
        {
            // Business rules can go here later
            Dedal.InsertDesignation(designationName);
        }



        public void RemoveDesignation(int designationId)
        {
            if (designationId <= 0)
                throw new ApplicationException("Invalid designation selected.");

            try
            {
                Dedal.DeleteDesignation(designationId);
            }
            catch (SqlException ex)
            {
                // FK constraint (still possible even with simple SP)
                if (ex.Number == 547)
                {
                    throw new ApplicationException(
                        "Cannot delete this designation because it is linked to other records."
                    );
                }

                // Any other SQL error
                throw new ApplicationException(
                    "Failed to delete designation. Please try again."
                );
            }
        }


        public void UpdateDesignation(int designationId, string designationName)
        {
            // Business rules can be added here (e.g. validation)
            Dedal.UpdateDesignation(designationId, designationName);
        }

    }
}
    

