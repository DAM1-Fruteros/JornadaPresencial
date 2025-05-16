package org.example.servlet;

import org.example.dao.ProductDao;
import org.example.database.Database;
import org.example.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;

import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.UUID;


@WebServlet("/edit_product")
@MultipartConfig

public class EditProductServlet extends HttpServlet {

    private ArrayList<String> errors;

    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();
        if ((currentSession.getAttribute("role") == null) || (!currentSession.getAttribute("role").equals("admin"))){
            response.sendRedirect("/practicas_app/login.jsp");
            return;
        }

        if (!validate(request)){
            response.getWriter().print(errors.toString());
            return;
        }
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String price = request.getParameter("price");
        String quantity = request.getParameter("quantity");
        String category = request.getParameter("category");
        Part image = request.getPart("image");
        String rate = request.getParameter("rate");


        try {
            Database database = new Database();
            database.connect();
            ProductDao productDao = new ProductDao(database.getConnection());
            Product product = new Product();
            product.setName(name);
            product.setDescription(description);
            product.setPrice(Float.parseFloat(price));
            product.setQuantity(Integer.parseInt(quantity));
            product.setCategory(category);
            product.setRate(Float.parseFloat(rate));
            product.setId(id);
    /*
            String filename = "film.jpg";
            if (image.getSize() != 0) {
                //creo un nombre de foto aleatorio y por ahora solo damos por válido jpg
                filename = UUID.randomUUID().toString() + ".jpg";

                String imagePath = "C:/apache-tomcat-9.0.102/webapps/peliculas-images";
                InputStream inputStream = image.getInputStream(); //representación en datos de la imagen
                Files.copy(inputStream, Path.of(imagePath + File.separator + filename));
            }
            pelicula.setImagen(filename);
*/
            boolean edited = productDao.editProduct(product);
            if (edited) {
                response.getWriter().print("ok");
            } else {
                response.getWriter().print("No se ha podido actualizar el producto");
            }

        } catch (SQLException sqle) {
            try {
                response.getWriter().println("No se ha podido conectar con la base de datos");
                sqle.printStackTrace();
                response.getWriter().println("Error SQL: " + sqle.getMessage());
            } catch (IOException ioe){
                ioe.printStackTrace();
            }
            sqle.printStackTrace();
        } catch (ClassNotFoundException cnfe){
            cnfe.printStackTrace();
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
    }

    private boolean validate(HttpServletRequest request){
        errors = new ArrayList<>();
        if (request.getParameter("name").isEmpty()){
            errors.add("Name is required");
        }
        if (request.getParameter("description").isEmpty()){
            errors.add("Description is required");
        }
        if (request.getParameter("price").isEmpty()){
            errors.add("Price is required");
        }
        return errors.isEmpty();
    }
}
