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
        if (currentSession.getAttribute("role") == null){
            response.sendRedirect("/practicas_app/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if (!validate(request)){
            response.getWriter().print(errors.toString());
            return;
        }

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String price = request.getParameter("price");
        String quantity = request.getParameter("quantity");
        String category = request.getParameter("category");
        Part image = request.getPart("image");
        String rate  = request.getParameter("rate");

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

            String filename = "product.jpg";
            if (action.equals("Send")) {
                if (image.getSize() != 0) {
                    //creo un nombre de foto aleatorio y por ahora solo damos por válido jpg
                    filename = UUID.randomUUID().toString() + ".jpg";

                    String imagePath = "C:\\Users\\Hermes\\Downloads\\apache-tomcat-9.0.102\\apache-tomcat-9.0.102\\webapps\\practicas_app_images";
                    InputStream inputStream = image.getInputStream(); //representación en datos de la imagen
                    Files.copy(inputStream, Path.of(imagePath + File.separator + filename));
                }
                product.setImage(filename);
            } else{
                product.setId(Integer.parseInt(request.getParameter("productId")));
            }

            boolean added = false;
            if (action.equals("Send")) {
                added = productDao.addProduct(product);
            } else {
                added = productDao.editProduct(product);
            }

            if (added) {
                response.getWriter().println("ok");
            } else {
                response.getWriter().println("Couldn't send the product");
            }

//            boolean added = productDao.addProduct(product);
//            if (added) {
//                response.getWriter().print("ok");
//            } else {
//                response.getWriter().print("No se ha podido registrar la película");
//            }

        } catch (SQLException sqle) {
            try {
                response.getWriter().println("Database couldn't be connected");
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
