package com.poly.service;

import com.poly.dto.LoginDTO;
import com.poly.dto.RegisterDTO;
import com.poly.model.User;
import java.util.List;

public interface UserService {
	boolean register(RegisterDTO registerDTO);

	boolean login(LoginDTO loginDTO);

	int countTotalCustomers();

	List<User> getAllUsers();

	List<User> getUsersByGender(Boolean gender);

	User getUserByUsername(String username);

	void saveOrUpdateUser(User user);

	void deleteUser(Integer usersId);

	int getTotalUsers();

	int getTotalProducts();
}
