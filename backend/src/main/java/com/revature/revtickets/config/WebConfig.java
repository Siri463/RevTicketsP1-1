package com.revature.revtickets.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/display/**")
            .addResourceLocations("file:backend/public/display/");

        registry.addResourceHandler("/banner/**")
            .addResourceLocations("file:backend/public/banner/");
    }
}
