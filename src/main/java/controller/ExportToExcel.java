// package controller;

// import org.apache.poi.ss.usermodel.*;
// import org.apache.poi.xssf.usermodel.XSSFWorkbook;

// import javax.servlet.ServletException;
// import javax.servlet.annotation.WebServlet;
// import javax.servlet.http.HttpServlet;
// import javax.servlet.http.HttpServletRequest;
// import javax.servlet.http.HttpServletResponse;
// import java.io.IOException;
// import java.time.LocalDate;
// import java.util.List;

// import model.Orders;
// import service.OrdersService;


// @WebServlet(urlPatterns = "/exportOrders")
// public class ExportToExcel extends HttpServlet {


//     @Override
//     protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//     	OrdersService ordersService = new OrdersService();
//         List<Orders> orders = ordersService.getAllOrder();

//         Workbook workbook = new XSSFWorkbook();
//         Sheet sheet = workbook.createSheet("Orders");

//         Row headerRow = sheet.createRow(0);
//         String[] headers = {"ID", "User ID", "Created Date", "Total Money", "Order Status"};
//         for (int i = 0; i < headers.length; i++) {
//             Cell cell = headerRow.createCell(i);
//             cell.setCellValue(headers[i]);
//         }

//         int rowNum = 1;
//         for (Orders order : orders) {
//             Row row = sheet.createRow(rowNum++);
//             row.createCell(0).setCellValue(order.getId());
//             row.createCell(1).setCellValue(order.getUserId());
//             row.createCell(2).setCellValue(order.getCreatedDate().toString());
//             row.createCell(3).setCellValue(order.getTotalMoney());
//             row.createCell(4).setCellValue(order.getOrderStatus());
//         }

//         response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
//         response.setHeader("Content-Disposition", "attachment; filename=orders.xlsx");

//         workbook.write(response.getOutputStream());
//         workbook.close();
//     }
// }
