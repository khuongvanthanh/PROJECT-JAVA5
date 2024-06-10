package org.example.utils;

import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.*;
import java.util.Objects;

public class HandleImages {
    private static final String location = "images/";
    static Path path = Paths.get(location);

    public static String handleMultipartFile(MultipartFile multipartFile) throws IOException {
        Path fileName = null;
        try (InputStream inputStream = multipartFile.getInputStream()) {
            fileName = Paths.get(Objects.requireNonNull(multipartFile.getOriginalFilename()));
            Files.copy(inputStream, path.resolve(fileName.getFileName()), StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException ignored) {
        }
        assert fileName != null;
        return fileName.getFileName().toString();
    }
}
