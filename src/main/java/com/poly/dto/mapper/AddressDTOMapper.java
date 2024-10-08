package com.poly.dto.mapper;

import com.poly.dto.response.AddressReponse;
import com.poly.model.Address;
import org.springframework.stereotype.Component;

import java.util.function.Function;

@Component
public class AddressDTOMapper implements Function<Address, AddressReponse> {
    @Override
    public AddressReponse apply(Address address) {
        return AddressReponse.builder()
                .addressId(address.getId())
                .streetName(address.getStreet())
                .communeName(address.getCommune().getCommune_name())
                .districtName(address.getDistrict().getDistrict_name())
                .provinceName(address.getProvince().getProvince_name())
                .build();
    }
}
