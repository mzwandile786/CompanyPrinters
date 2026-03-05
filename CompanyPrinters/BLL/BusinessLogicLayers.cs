using CompanyPrinters.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace CompanyPrinters.BLL
{
    //Business Logic Layer
    public class BusinessLogicLayers
    {
        public DataTable Login(string username, string password)
        {
            DALclass dal = new DALclass();

            // Basic validation (business rules)
            if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password))
            {
                return null;
            }

            // Call DAL
            return dal.Login(username.Trim(), password);
        }

        private void ValidatePrinter(
    string printerName,
    string folderToMonitor,
    string outputType,
    string fileOutput,
    int printerMakeId)
        {
            // 1. Required fields
            if (string.IsNullOrWhiteSpace(printerName))
                throw new ApplicationException("Printer Name is required.");

            if (string.IsNullOrWhiteSpace(folderToMonitor))
                throw new ApplicationException("Folder To Monitor is required.");

            if (string.IsNullOrWhiteSpace(outputType))
                throw new ApplicationException("Output Type is required.");

            if (string.IsNullOrWhiteSpace(fileOutput))
                throw new ApplicationException("File Output is required.");

            // 2. Trim inputs
            printerName = printerName.Trim();
            folderToMonitor = folderToMonitor.Trim();
            outputType = outputType.Trim().ToUpper();
            fileOutput = fileOutput.Trim();

            // 3. Allowed output types
            /* string[] allowedTypes = { "FTP Output", "File Output", "PDF" };
             if (!allowedTypes.Contains(outputType))
                 throw new ApplicationException("Invalid output type selected.");
            */
            string[] allowedTypes = { "FTP Output", "File Output", "PDF" };

            if (!allowedTypes.Any(x =>
                x.Equals(outputType.Trim(), StringComparison.OrdinalIgnoreCase)))
            {
                throw new ApplicationException("Invalid output type selected.");
            }

            // 4. Printer make validation
            if (printerMakeId <= 0)
                throw new ApplicationException("Invalid printer make.");
        }

        public void InsertPrinterBusiness(
        string printerName,
        string folderToMonitor,
        string outputType,
        string fileOutput,
        bool active,
        int printerMakeId)
        {
            //  Shared validation
            ValidatePrinter(printerName, folderToMonitor, outputType, fileOutput, printerMakeId);

            //  Call DAL
            DALclass dal = new DALclass();
            dal.InsertPrinter(
                printerName.Trim(),
                folderToMonitor.Trim(),
                outputType.Trim().ToUpper(),
                fileOutput.Trim(),
                active,
                printerMakeId
            );
        }

        public void UpdatePrinterBusiness(
        int engenPrintersId,
        string printerName,
        string folderToMonitor,
        string outputType,
        string fileOutput,
        bool active,
        int printerMakeId)
        {
            if (engenPrintersId <= 0)
                throw new ApplicationException("Invalid printer ID.");

            //  Shared validation
            ValidatePrinter(printerName, folderToMonitor, outputType, fileOutput, printerMakeId);

            // Call DAL
            DALclass dal = new DALclass();
            dal.UpdatePrinter(
                engenPrintersId,
                printerName.Trim(),
                folderToMonitor.Trim(),
                outputType.Trim().ToUpper(),
                fileOutput.Trim(),
                active,
                printerMakeId
            );
        }



        private void ValidateUser(
    string firstName,
    string lastName,
    string email,
    string userName,
    string password,
    int designationId)
        {
            // 1. Required fields
            if (string.IsNullOrWhiteSpace(firstName))
                throw new ApplicationException("First Name is required.");

            if (string.IsNullOrWhiteSpace(lastName))
                throw new ApplicationException("Last Name is required.");

            if (string.IsNullOrWhiteSpace(email))
                throw new ApplicationException("Email address is required.");

            if (string.IsNullOrWhiteSpace(userName))
                throw new ApplicationException("Username is required.");

            if (string.IsNullOrWhiteSpace(password))
                throw new ApplicationException("Password is required.");

            // 2. Format Validation (Email)
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                if (addr.Address != email.Trim()) throw new Exception();
            }
            catch
            {
                throw new ApplicationException("The Email format is invalid.");
            }

            // 3. Length checks (Optional but recommended)
            if (password.Length < 6)
                throw new ApplicationException("Password must be at least 6 characters long.");

            // 4. Designation validation
            if (designationId <= 0)
                throw new ApplicationException("Please select a valid Designation.");
        }

        public class PrinterBLL
        {
            private readonly DALclass _dal = new DALclass();

            /// <summary>
            /// Retrieves a list of printer manufacturers.
            /// </summary>
            /// <returns>DataTable containing printer makes.</returns>
            public DataTable GetPrinterMakes()
            {
                try
                {
                    // You can add logic here (e.g., logging or security checks)
                    DataTable dt = _dal.GetPrinterMakes();

                    if (dt == null || dt.Rows.Count == 0)
                    {
                        // Logic for handling empty data if necessary
                    }

                    return dt;
                }
                catch (Exception ex)
                {
                    // Handle or log the exception according to your policy
                    throw new Exception("Error retrieving printer makes: " + ex.Message);
                }
            }

            public DataTable GetPrinters()
            {
                try
                {
                    // Call the DAL method
                    DataTable dt = _dal.GetPrinters();

                    // Optional: Perform business logic here
                    // Example: Adding a calculated column or formatting data before it hits the Grid

                    return dt;
                }
                catch (Exception ex)
                {
                    // Log the error (e.g., to a text file or database)
                    throw new Exception("Error fetching printer records: " + ex.Message);
                }
            }
            // Ensure the parameter name and type (int?) match what you use in the UI
            public DataTable SearchPrinters(int? printerMakeId, DateTime? fromDate, DateTime? toDate)
            {
                // 1. Business Logic: End of Day adjustment
                if (toDate.HasValue)
                {
                    toDate = toDate.Value.Date.AddDays(1).AddSeconds(-1);
                }

                // 2. Pass to DAL (Make sure your DAL method also accepts int? printerMakeId)
                return _dal.SearchPrinters(printerMakeId, fromDate, toDate);
            }



            // Users BLL
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
            }


        }
    }
}




  