<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Báo Cáo Thống Kê</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
    crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
    crossorigin="anonymous"></script>
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style>
    body {
        background-color: #f8f9fa;
    }
    .card-single {
        background: #fff;
        border-radius: 5px;
        margin: 15px 0;
        padding: 20px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        display: flex;
        align-items: center;
        justify-content: space-between;
        transition: transform 0.3s ease;
    }
    .card-single:hover {
        transform: translateY(-10px);
    }
    .card-single div {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
    }
    .card-single h1 {
        font-size: 2.5rem;
        margin: 0;
    }
    .card-single span {
        color: #6c757d;
    }
    .card-single i {
        font-size: 3rem;
        color: #007bff;
    }
    .table thead th {
        background-color: #007bff;
        color: #fff;
    }
    .table tbody tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    .card-header {
        background-color: #007bff;
        color: white;
        padding: 15px;
        border-radius: 5px 5px 0 0;
    }
    .card-body {
        padding: 20px;
    }
    .btn-primary {
        background-color: #007bff;
        border-color: #007bff;
        transition: background-color 0.3s ease;
    }
    .btn-primary:hover {
        background-color: #0056b3;
        border-color: #0056b3;
    }
    .card-single{
    background-color: #33FFFF;
    }
</style>
</head>
<body>
    <div class="container-fluid">
        <div class="row mt-5" >
            <div class="col-md-3" >
                <div class="card-single">
                    <div>
                        <h1>${totalCustomers}</h1>
                        <span>Customers</span>
                    </div>
                    <i class="bi bi-people"></i>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card-single">
                    <div>
                        <h1>${totalProducts}</h1>
                        <span>Products</span>
                    </div>
                    <i class="bi bi-clipboard-data"></i>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card-single">
                    <div>
                        <h1>${totalOrders}</h1>
                        <span>Orders</span>
                    </div>
                    <i class="bi bi-bag"></i>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card-single">
                    <div>
                        <h1>${totalAmount}</h1>
                        <span>Total Amount</span>
                    </div>
                    <i class="bi bi-wallet2"></i>
                </div>
            </div>
        </div>

        <div class="container-fluid mt-4">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h4>Present Project</h4>
                            <button class="btn btn-primary">
                                See all <span class="bi bi-arrow-right"></span>
                            </button>
                        </div>
                        <div class="card-body">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Product</th>
                                        <th>Quantity</th>
                                        <th>Author</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${products}" var="product">
                                        <tr>
                                            <td><c:out value="${product.productName}" /></td>
                                            <td><c:out value="${product.quantity}" /></td>
                                            <td><c:out value="${product.author}" /></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
