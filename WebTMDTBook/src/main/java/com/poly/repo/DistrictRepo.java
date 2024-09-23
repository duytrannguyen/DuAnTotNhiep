package com.poly.repo;

import com.poly.model.District;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DistrictRepo extends JpaRepository<District,Integer> {
}
