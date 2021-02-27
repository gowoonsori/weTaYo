package wetayo.wetayoapi.wetayo;

import graphql.GraphQLException;
import graphql.kickstart.tools.GraphQLMutationResolver;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;
import wetayo.wetayoapi.rides.Ride;
import wetayo.wetayoapi.rides.RideDto;
import wetayo.wetayoapi.rides.RideService;

@Component
public class WetayoMutation implements GraphQLMutationResolver {
    private final RideService rideService;
    private final ModelMapper modelMapper;

    WetayoMutation(RideService rideService,ModelMapper modelMapper) {
        this.rideService = rideService;
        this.modelMapper = modelMapper;
    }

    public RideDto createRide(Integer stationId, Integer routeId) {
        Ride ride = rideService.addRide(stationId,routeId);
        return modelMapper.map(ride,RideDto.class);
    }

    public Boolean deleteRide(Integer stationId, Integer routeId) {
        try{
            rideService.deleteRide(stationId,routeId);
        }catch (GraphQLException e){
            return false;
        }
        return true;
    }
}
