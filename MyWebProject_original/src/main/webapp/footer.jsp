<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>Footer</title>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
   <style>
       .footer {
           background: #111;
           color: #fff;
           padding: 3rem 0;
           margin-top: 3rem;
           border-top: 1px solid #333;
       }

       .footer-container {
           max-width: 1200px;
           margin: 0 auto;
           padding: 0 1rem;
           display: grid;
           grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
           gap: 2rem;
       }

       .footer-section {
           display: flex;
           flex-direction: column;
           gap: 1rem;
       }

       .footer-section h3 {
           color: #007bff;
           font-size: 1.2rem;
           margin-bottom: 0.5rem;
       }

       .footer-links {
           display: flex;
           flex-direction: column;
           gap: 0.5rem;
       }

       .footer-links a {
           color: #9ca3af;
           text-decoration: none;
           transition: color 0.3s ease;
           font-size: 0.9rem;
       }

       .footer-links a:hover {
           color: #007bff;
       }

       .footer-social {
           display: flex;
           gap: 1rem;
           margin-top: 0.5rem;
       }

       .footer-social a {
           color: #9ca3af;
           text-decoration: none;
           font-size: 1.5rem;
           transition: color 0.3s ease;
       }

       .footer-social a:hover {
           color: #007bff;
       }

       .footer-bottom {
           margin-top: 2rem;
           padding-top: 2rem;
           border-top: 1px solid #333;
           text-align: center;
           color: #9ca3af;
           font-size: 0.9rem;
       }

       @media (max-width: 768px) {
           .footer-container {
               grid-template-columns: 1fr;
               text-align: center;
           }

           .footer-social {
               justify-content: center;
           }
       }
   </style>
</head>
<body>
   <footer class="footer">
       <div class="footer-container">
           <div class="footer-section">
               <h3>About Us</h3>
               <div class="footer-links">
                   <a href="#">회사 소개</a>
                   <a href="#">이용약관</a>
                   <a href="#">개인정보처리방침</a>
                   <a href="#">고객센터</a>
               </div>
           </div>      
       </div>

       <div class="footer-bottom">
           <p>&copy; 2024 Rhine Lab. All rights reserved.</p>
       </div>
   </footer>
</body>
</html>>