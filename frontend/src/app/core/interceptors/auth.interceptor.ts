import { HttpInterceptorFn } from '@angular/common/http';

export const authInterceptor: HttpInterceptorFn = (req, next) => {
  const token = localStorage.getItem('token');
  
  if (token) {
    // Add Authorization header with Bearer token
    req = req.clone({
      setHeaders: {
        Authorization: `Bearer ${token}`
      }
    });
    console.log('[AuthInterceptor] Token added to request:', req.url);
  } else {
    console.log('[AuthInterceptor] No token found for request:', req.url);
  }
  
  return next(req);
};
