package wetayo.wetayoapi.stations;


import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.locationtech.jts.geom.Point;
import org.n52.jackson.datatype.jts.GeometryDeserializer;
import org.n52.jackson.datatype.jts.GeometrySerializer;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

@Builder
@Entity
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
@EqualsAndHashCode(of = "id") @Table(name = "STATION")
public class Station {
    @Id
    @Column(name = "STATION_ID")
    @NotNull
    private Integer id;

    @Column(name = "STATION_NAME")
    @NotEmpty @NotNull
    private String stationName;

    @Column(name = "GPS", columnDefinition = "POINT")
    @JsonSerialize(using = GeometrySerializer.class)
    @JsonDeserialize(contentUsing = GeometryDeserializer.class)
    private Point gps;

    @Column(name = "REGION_NAME")
    @NotEmpty @NotNull
    private String regionName;

    @Column(name = "CENTER_ID")
    @NotNull
    private Integer centerId;

    @Column(name = "CENTER_YN")
    @NotEmpty @NotNull
    private String centerYn;

    @Column(name = "MOBILE_NUMBER")
    @NotEmpty @NotNull
    private String mobileNumber;

    @Column(name = "DISTRICT_CODE")
    @NotNull
    private Integer districtCode;

    @CreationTimestamp
    @Column(name = "CREATED_TIME", insertable = false)
    private LocalDateTime createdTime;
    @UpdateTimestamp
    @Column(name = "UPDATED_TIME", updatable = false, insertable = false)
    private LocalDateTime updatedTime;

}
