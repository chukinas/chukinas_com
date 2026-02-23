defmodule Chukinas.Bids.DummyActiveBids do
  # Provides dummy data for the active bids screen
  # This file exists to make it cleaner and easier to generate uuids at compile time.

  def get_without_uuid() do
    [
      %{
        bid_number: "B26-0001",
        date_rcv: ~D[2026-01-15],
        date_due: ~D[2026-01-28],
        project_name: "Zion Baptist Church",
        estimator: "JM",
        salesperson: "RK"
      },
      %{
        bid_number: "B26-0002",
        date_rcv: ~D[2026-01-18],
        date_due: ~D[2026-02-05],
        project_name: "Adidas Distribution Center",
        estimator: "TL",
        salesperson: "MG"
      },
      %{
        bid_number: "B26-0003",
        date_rcv: ~D[2026-01-22],
        date_due: ~D[2026-02-15],
        project_name: "Liberty Coca Cola - Low Voltage",
        estimator: "SM",
        salesperson: "RK"
      },
      %{
        bid_number: "B26-0004",
        date_rcv: ~D[2026-01-25],
        date_due: ~D[2026-02-10],
        project_name: "Downtown Medical Plaza",
        estimator: "JM",
        salesperson: "DH"
      },
      %{
        bid_number: "B26-0005",
        date_rcv: ~D[2026-01-28],
        date_due: ~D[2026-02-20],
        project_name: "Riverside High School Gymnasium",
        estimator: "TL",
        salesperson: "MG"
      },
      %{
        bid_number: "B26-0006",
        date_rcv: ~D[2026-01-30],
        date_due: ~D[2026-02-12],
        project_name: "First National Bank Branch",
        estimator: "SM",
        salesperson: "RK"
      },
      %{
        bid_number: "B26-0007",
        date_rcv: ~D[2026-02-01],
        date_due: ~D[2026-02-18],
        project_name: "Target Store Remodel",
        estimator: "JM",
        salesperson: "DH"
      },
      %{
        bid_number: "B26-0008",
        date_rcv: ~D[2026-01-20],
        date_due: ~D[2026-02-08],
        project_name: "Parkview Apartments",
        estimator: "TL",
        salesperson: "MG"
      },
      %{
        bid_number: "B26-0009",
        date_rcv: ~D[2026-01-16],
        date_due: ~D[2026-01-25],
        project_name: "Industrial Warehouse 5",
        estimator: "SM",
        salesperson: "RK"
      },
      %{
        bid_number: "B26-0010",
        date_rcv: ~D[2026-01-19],
        date_due: ~D[2026-02-14],
        project_name: "St. Mary's Hospital Emergency Dept",
        estimator: "JM",
        salesperson: "DH"
      },
      %{
        bid_number: "B26-0011",
        date_rcv: ~D[2026-01-23],
        date_due: ~D[2026-02-16],
        project_name: "Metro Transit Station",
        estimator: "TL",
        salesperson: "MG"
      },
      %{
        bid_number: "B26-0012",
        date_rcv: ~D[2026-01-26],
        date_due: ~D[2026-02-03],
        project_name: "Whole Foods Market",
        estimator: "SM",
        salesperson: "RK"
      },
      %{
        bid_number: "B26-0013",
        date_rcv: ~D[2026-01-29],
        date_due: ~D[2026-02-22],
        project_name: "Tech Campus Building C",
        estimator: "JM",
        salesperson: "DH"
      },
      %{
        bid_number: "B26-0014",
        date_rcv: ~D[2026-02-02],
        date_due: ~D[2026-02-17],
        project_name: "Grace Community Church",
        estimator: "TL",
        salesperson: "MG"
      },
      %{
        bid_number: "B26-0015",
        date_rcv: ~D[2026-01-17],
        date_due: ~D[2026-01-30],
        project_name: "Marriott Hotel Renovation",
        estimator: "SM",
        salesperson: "RK"
      },
      %{
        bid_number: "B26-0016",
        date_rcv: ~D[2026-01-21],
        date_due: ~D[2026-02-11],
        project_name: "City Hall Annex",
        estimator: "JM",
        salesperson: "DH"
      },
      %{
        bid_number: "B26-0017",
        date_rcv: ~D[2026-01-24],
        date_due: ~D[2026-02-19],
        project_name: "Amazon Fulfillment Center",
        estimator: "TL",
        salesperson: "MG"
      },
      %{
        bid_number: "B26-0018",
        date_rcv: ~D[2026-01-27],
        date_due: ~D[2026-02-09],
        project_name: "Oakwood Elementary School",
        estimator: "SM",
        salesperson: "RK"
      },
      %{
        bid_number: "B26-0019",
        date_rcv: ~D[2026-01-31],
        date_due: ~D[2026-02-24],
        project_name: "Nike Retail Store",
        estimator: "JM",
        salesperson: "DH"
      },
      %{
        bid_number: "B26-0020",
        date_rcv: ~D[2026-02-03],
        date_due: ~D[2026-02-13],
        project_name: "Manufacturing Plant Expansion",
        estimator: "TL",
        salesperson: "MG"
      },
      %{
        bid_number: "B26-0021",
        date_rcv: ~D[2026-01-14],
        date_due: ~D[2026-01-27],
        project_name: "Sunset Senior Living",
        estimator: "SM",
        salesperson: "RK"
      },
      %{
        bid_number: "B26-0022",
        date_rcv: ~D[2026-01-18],
        date_due: ~D[2026-02-06],
        project_name: "Chase Bank Regional Office",
        estimator: "JM",
        salesperson: "DH"
      },
      %{
        bid_number: "B26-0023",
        date_rcv: ~D[2026-01-22],
        date_due: ~D[2026-02-15],
        project_name: "LA Fitness Gym",
        estimator: "TL",
        salesperson: "MG"
      },
      %{
        bid_number: "B26-0024",
        date_rcv: ~D[2026-01-25],
        date_due: ~D[2026-02-04],
        project_name: "County Courthouse Renovation",
        estimator: "SM",
        salesperson: "RK"
      },
      %{
        bid_number: "B26-0025",
        date_rcv: ~D[2026-01-28],
        date_due: ~D[2026-02-21],
        project_name: "Pepsi Bottling Plant",
        estimator: "JM",
        salesperson: "DH"
      },
      %{
        bid_number: "B26-0026",
        date_rcv: ~D[2026-01-30],
        date_due: ~D[2026-02-11],
        project_name: "University Library Addition",
        estimator: "TL",
        salesperson: "MG"
      },
      %{
        bid_number: "B26-0027",
        date_rcv: ~D[2026-02-01],
        date_due: ~D[2026-02-07],
        project_name: "Starbucks Distribution Hub",
        estimator: "SM",
        salesperson: "RK"
      },
      %{
        bid_number: "B26-0028",
        date_rcv: ~D[2026-01-20],
        date_due: ~D[2026-02-12],
        project_name: "Hope Lutheran Church",
        estimator: "JM",
        salesperson: "DH"
      },
      %{
        bid_number: "B26-0029",
        date_rcv: ~D[2026-01-16],
        date_due: ~D[2026-01-29],
        project_name: "Data Center Tier 3",
        estimator: "TL",
        salesperson: "MG"
      },
      %{
        bid_number: "B26-0030",
        date_rcv: ~D[2026-01-19],
        date_due: ~D[2026-02-16],
        project_name: "CVS Pharmacy New Build",
        estimator: "SM",
        salesperson: "RK"
      },
      %{
        bid_number: "B26-0031",
        date_rcv: ~D[2026-01-23],
        date_due: ~D[2026-02-14],
        project_name: "Boeing Assembly Building",
        estimator: "JM",
        salesperson: "DH"
      },
      %{
        bid_number: "B26-0032",
        date_rcv: ~D[2026-01-26],
        date_due: ~D[2026-02-18],
        project_name: "Hilton Garden Inn",
        estimator: "TL",
        salesperson: "MG"
      },
      %{
        bid_number: "B26-0033",
        date_rcv: ~D[2026-01-29],
        date_due: ~D[2026-02-10],
        project_name: "Police Station Upgrade",
        estimator: "SM",
        salesperson: "RK"
      },
      %{
        bid_number: "B26-0034",
        date_rcv: ~D[2026-02-02],
        date_due: ~D[2026-02-25],
        project_name: "Ford Dealership",
        estimator: "JM",
        salesperson: "DH"
      },
      %{
        bid_number: "B26-0035",
        date_rcv: ~D[2026-01-17],
        date_due: ~D[2026-02-02],
        project_name: "Costco Warehouse",
        estimator: "TL",
        salesperson: "MG"
      },
      %{
        bid_number: "B26-0036",
        date_rcv: ~D[2026-01-21],
        date_due: ~D[2026-02-13],
        project_name: "Memorial Hospital ICU",
        estimator: "SM",
        salesperson: "RK"
      },
      %{
        bid_number: "B26-0037",
        date_rcv: ~D[2026-01-24],
        date_due: ~D[2026-02-20],
        project_name: "Home Depot Store",
        estimator: "JM",
        salesperson: "DH"
      },
      %{
        bid_number: "B26-0038",
        date_rcv: ~D[2026-01-27],
        date_due: ~D[2026-02-08],
        project_name: "Tesla Service Center",
        estimator: "TL",
        salesperson: "MG"
      },
      %{
        bid_number: "B26-0039",
        date_rcv: ~D[2026-01-31],
        date_due: ~D[2026-02-23],
        project_name: "Office Tower Phase 2",
        estimator: "SM",
        salesperson: "RK"
      },
      %{
        bid_number: "B26-0040",
        date_rcv: ~D[2026-02-03],
        date_due: ~D[2026-02-17],
        project_name: "Walmart Supercenter",
        estimator: "JM",
        salesperson: "DH"
      },
      %{
        bid_number: "B26-0041",
        date_rcv: ~D[2026-01-14],
        date_due: ~D[2026-01-26],
        project_name: "FedEx Sorting Facility",
        estimator: "TL",
        salesperson: "MG"
      },
      %{
        bid_number: "B26-0042",
        date_rcv: ~D[2026-01-18],
        date_due: ~D[2026-02-05],
        project_name: "Chipotle Restaurant",
        estimator: "SM",
        salesperson: "RK"
      },
      %{
        bid_number: "B26-0043",
        date_rcv: ~D[2026-01-22],
        date_due: ~D[2026-02-19],
        project_name: "Apple Store Renovation",
        estimator: "JM",
        salesperson: "DH"
      },
      %{
        bid_number: "B26-0044",
        date_rcv: ~D[2026-01-25],
        date_due: ~D[2026-02-03],
        project_name: "Fire Station #7",
        estimator: "TL",
        salesperson: "MG"
      },
      %{
        bid_number: "B26-0045",
        date_rcv: ~D[2026-01-28],
        date_due: ~D[2026-02-22],
        project_name: "Lowe's Home Improvement",
        estimator: "SM",
        salesperson: "RK"
      },
      %{
        bid_number: "B26-0046",
        date_rcv: ~D[2026-01-30],
        date_due: ~D[2026-02-15],
        project_name: "YMCA Recreation Center",
        estimator: "JM",
        salesperson: "DH"
      },
      %{
        bid_number: "B26-0047",
        date_rcv: ~D[2026-02-01],
        date_due: ~D[2026-02-09],
        project_name: "BP Gas Station",
        estimator: "TL",
        salesperson: "MG"
      },
      %{
        bid_number: "B26-0048",
        date_rcv: ~D[2026-01-20],
        date_due: ~D[2026-02-11],
        project_name: "Salvation Army Thrift Store",
        estimator: "SM",
        salesperson: "RK"
      },
      %{
        bid_number: "B26-0049",
        date_rcv: ~D[2026-01-16],
        date_due: ~D[2026-01-31],
        project_name: "AT&T Cell Tower",
        estimator: "JM",
        salesperson: "DH"
      },
      %{
        bid_number: "B26-0050",
        date_rcv: ~D[2026-01-19],
        date_due: ~D[2026-02-14],
        project_name: "McDonald's Drive-Thru Remodel",
        estimator: "TL",
        salesperson: "MG"
      }
    ]
  end
end
