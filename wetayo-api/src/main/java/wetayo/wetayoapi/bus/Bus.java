package wetayo.wetayoapi.bus;

import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

@Builder
@Entity
@Getter @Setter @AllArgsConstructor @NoArgsConstructor
@EqualsAndHashCode(of = "id") @Table(name="BUS")
public class Bus {
    @Id
    @Column(name = "BUS_ID")
    private Integer id;

    @NotEmpty
    @Column(name = "PLATE_NUMBER")
    private String plateNumber;

    @NotEmpty
    @Column(name = "COMPANY_NAME")
    private String companyName;
    @NotNull
    @Column(name = "COMPANY_ID")
    private Integer companyId;

    @Column(name = "BUS_TYPE")
    private int busType;
    @Column(name = "LOW_PLATE")
    private int lowPlate;
    @NotNull
    @Column(name = "USE_YN")
    private int useYn;

    @NotNull
    @Column(name = "AREA_CODE")
    private Integer areaCode;

    @NotNull
    @Column(name = "SIDO_CODE")
    private Integer sidoCode;

    @NotEmpty
    @Column(name = "ADMIN_NAME")
    private String adminName;

    @CreationTimestamp
    @Column(name = "CREATED_TIME", insertable = false)
    private LocalDateTime createdTime;

    @UpdateTimestamp
    @Column(name = "UPDATED_TIME", updatable = false, insertable = false)
    private LocalDateTime updatedTime;
}
