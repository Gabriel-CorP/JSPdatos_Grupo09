<%@page contentType="text/html" pageEncoding="iso-8859-1" import="java.sql.*,net.ucanaccess.jdbc.*" %>
 <html>
 <head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>Actualizar, Eliminar, Crear registros.</title>
 </head>
 <body>

<H1>MANTENIMIENTO DE LIBROS</H1>
<a type=url style="margin-left: 10px;" href="listado-csv.jsp" download="listadoLibros.csv">Descargar Listado CSV</a>
<form action="matto.jsp" method="post" name="Actualizar">
 <table>
 <tr>
 <td>ISBN<input type="text" name="isbn" value="" size="40"/>
</td>
  </tr>
 <tr>
 <td>T�tulo<input type="text" name="titulo" value="" size="50"/></td>
 </tr>
 <tr>
  <td class="etiqueta">Autor 
    <input onkeyup="mensajeCreate()" id="id_autor" name="autor" size="50" type="text" value="" /></td>
  </tr>
 <tr>
      <td class="etiqueta">Editorial 
          <%
          ServletContext context2 = request.getServletContext();
          String path2 = context2.getRealPath("/data");
          Connection conexion2 = getConnection(path2);
      
      
          if (!conexion2.isClosed())
          {
            
            Statement stEditorial = conexion2.createStatement();
            ResultSet rsEditorial = stEditorial.executeQuery("select * from editorial" );
          %>
          <select onkeyup="mensajeCreate()" id="id_editorial" name="editorial">
            <% while (rsEditorial.next()) { %>
              <option value="<% out.println(rsEditorial.getString("id")); %>"><% out.println(rsEditorial.getString("nombre")); %></option>
            <% } %>
          </select>
         
      </td>
   </tr>
   <% } %>
   <tr>
   <td class="etiqueta">Anio de Publicacion  
            <input onkeyup="mensajeCreate()" id="id_anioPublic" name="anioPublic" size="30" type="text" value="" /></td>
   </tr>
 <tr><td> Action <input type="radio" name="Action" value="Actualizar" /> Actualizar
 <input type="radio" name="Action" value="Eliminar" /> Eliminar
 <input type="radio" name="Action" value="Crear" checked /> Crear
  </td>
 <td><input type="SUBMIT" value="ACEPTAR" />
</td>
 </tr>
 </form>
 </tr>
 </table>
 </form>
<br><br>
<%!
public Connection getConnection(String path) throws SQLException {
String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
String filePath= path+"\\datos.mdb";
String userName="",password="";
String fullConnectionString = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;

    Connection conn = null;
try{
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
 conn = DriverManager.getConnection(fullConnectionString,userName,password);

}
 catch (Exception e) {
System.out.println("Error: " + e);
 }
    return conn;
}
%>
<%
ServletContext context = request.getServletContext();
String path = context.getRealPath("/data");
Connection conexion = getConnection(path);
   if (!conexion.isClosed()){
out.write("OK");
//out.write(path);//'
 
      Statement st = conexion.createStatement();
      ResultSet rs = st.executeQuery("select * from libros inner join editorial on libros.id_editorial = editorial.id" );

      // Ponemos los resultados en un table de html
      out.println("<table border=\"1\"><tr><td>Num.</td><td>ISBN</td><td>Titulo</td><td>Autor</td><td>Editorial</td><td>Anio de publicacion</td><td>Acci�n</td></tr>");
      int i=1;
      String isbn = "";
      while (rs.next())
      {
         isbn = rs.getString("isbn");
         out.println("<tr>");
         out.println("<td>"+ i +"</td>");
         out.println("<td>"+isbn+"</td>");
         out.println("<td>"+rs.getString("titulo")+"</td>");
         out.println("<td>"+rs.getString("autor")+"</td>");
         out.println("<td>"+rs.getString("nombre")+"</td>");
         out.println("<td>"+rs.getString("anioPublic")+"</td>");
         out.println("<td>"+"Actualizar<br><a href=matto.jsp?isbn2="+isbn+">Eliminar</a>"+"</td>");
         out.println("</tr>");
         i++;
      }
      out.println("</table>");
      // cierre de la conexion
      conexion.close();
}

%>
 </body>
 <script>//Script para Habilitar/Deshabilitar el boton Aceptar
    function mensajeCreate() 
    {
      console.log("create");
      const campo1 = document.getElementById("id_isbn");
      const campo2 = document.getElementById("id_titulo");
      const campo3 = document.getElementById("id_autor");
      const campo4 = document.getElementById("id_editorial");
      const campo5 = document.getElementById("id_anioPublic");
      const boton = document.getElementById("id_aceptar");
      console.log(boton)

      if (campo1.value.trim() !== "" && campo2.value.trim() !== "" && campo3.value.trim() !== "" && campo4.value.trim() !== "" && campo5.value.trim() !== "") 
      {
        console.log("Se muestra")
        boton.removeAttribute('disabled')
      }
      else {
        boton.setAttribute('disabled', "true");
      }
    }
  </script>
 </body>
