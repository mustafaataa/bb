﻿<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public class Handler : IHttpHandler {
    
        public void ProcessRequest(HttpContext context)
        {
            SqlConnection conn = new SqlConnection("Data Source=DESKTOP-VKIFPQG\\SQLEXPRESS;Initial Catalog=Mustafa;Integrated Security=True");
            conn.Open();
            SqlCommand cmd = conn.CreateCommand();

            var function = context.Request.QueryString["f"];
            string mahalleAdi = "";
            string wkt = "";
            string responce = "";
            responce = function + "#";
            switch (function)
            {
                case "mahalleekle":
                    mahalleAdi = context.Request.QueryString["mahalleAdi"];
                    wkt = context.Request.QueryString["WKT"];
                    cmd.CommandText = "insert into Mahalle(Mahalleadi,WKT)Values('" + mahalleAdi + "','" + wkt + "')";
                    int sonuc = cmd.ExecuteNonQuery();
                    if (sonuc > 0)
                        responce += "BASARILI";
                    else
                        responce += "HATALI";
                    cmd.Dispose();
                    conn.Close();
                    break;
                case "mahalleleriGetir":
                    cmd.CommandText = "Select * from Mahalle";
                    SqlDataAdapter adp = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable("MAHALLELER");
                    adp.Fill(dt);
                    adp.Dispose();
                    cmd.Dispose();
                    conn.Close();
                    responce = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                    break;
                default:
                    break;
            }
            context.Response.ContentType = "text/html";
            context.Response.Write(responce);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
