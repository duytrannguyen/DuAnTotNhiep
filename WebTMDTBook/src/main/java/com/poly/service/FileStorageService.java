package com.poly.service;

import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

public interface FileStorageService {

    public void save(MultipartFile file,UUID uuid);
}
