package com.poly.model;

import java.util.Date;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "Shippings")
public class Shipping {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int shipping_id;

	private String tracking_code;

	@Column(nullable = false)
	private String shipping_company;

	@Column(nullable = false)
	private String sender_address;

	@Column(nullable = false)
	private String recipient_address;

	@Column(nullable = false)
	private String status;

	@Column(nullable = false)
	@Temporal(TemporalType.DATE)
	private Date shipping_date;

	@Column(nullable = false)
	@Temporal(TemporalType.DATE)
	private Date delivery_date;

	@Column(nullable = false)
	private float COD;
}
