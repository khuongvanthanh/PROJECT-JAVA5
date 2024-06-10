package org.example.utils;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Controller
public class ImageController {
    @RequestMapping("/img/{photo}")
    ResponseEntity<ByteArrayResource> getImage(@PathVariable("photo") String photo) {
        if (photo != null && !photo.isEmpty()) {
            try {
                Path fileName = Paths.get("images", photo);
                byte[] buffer = Files.readAllBytes(fileName);
                ByteArrayResource byteArrayResource = new ByteArrayResource(buffer);
                MediaType mediaType;
                if (photo.toLowerCase().endsWith(".jpg") || photo.toLowerCase().endsWith(".jpeg")) {
                    mediaType = MediaType.IMAGE_JPEG;
                } else if (photo.toLowerCase().endsWith(".png")) {
                    mediaType = MediaType.IMAGE_PNG;
                } else {
                    return ResponseEntity.badRequest().build();
                }
                return ResponseEntity.ok()
                        .contentLength(buffer.length)
                        .contentType(mediaType)
                        .body(byteArrayResource);
            } catch (Exception e) {
                throw new RuntimeException("Not found!");
            }
        }
        return ResponseEntity.badRequest().build();
    }
}
