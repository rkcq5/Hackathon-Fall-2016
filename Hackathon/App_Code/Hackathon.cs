using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class Hackathon
{
}

public class UseCase
{
    public int UseCaseId { get; set; }
    public string UseCaseName { get; set; }
    public string Description { get; set; }
    public int CompanyId { get; set; }
}
public class Team
{
    public int TeamId { get; set; }
    public int UseCaseId { get; set; }
    public string TeamName { get; set; }
    public int TeamSize { get; set; }
    public string Technology { get; set; }
}
public class Company
{
    public int CompanyId { get; set; }
    public string CompanyName { get; set; }

    public int CompanyUserId { get; set; }
}

public class User
{
    public int UserId { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string UserName { get; set; }
    public string UserRole { get; set; }
    public string Email { get; set; }
}

public class Review
{
    public int UserId { get; set; }
    public int TeamId { get; set; }

    public int Marks { get; set; }

    public string Comments { get; set; }

}

public class Report
{
    public int Score { get; set; }
    public string TeamName { get; set; }
}