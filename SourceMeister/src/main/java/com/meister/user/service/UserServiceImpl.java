package com.meister.user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.meister.authorization.biz.AuthorizationBiz;
import com.meister.authorization.biz.AuthorizationBizImpl;
import com.meister.user.biz.UserBiz;
import com.meister.user.biz.UserBizImpl;
import com.meister.user.vo.UserVO;

public class UserServiceImpl implements UserService {

	private UserBiz userBiz;
	private AuthorizationBiz authorizationBiz;
<<<<<<< HEAD

	public UserServiceImpl() {
		userBiz = new UserBizImpl();
		authorizationBiz = new AuthorizationBizImpl();
	}
=======
	 public UserServiceImpl(){ 
	 userBiz = new UserBizImpl(); 
	 authorizationBiz = new AuthorizationBizImpl(); 
	 }
	 
>>>>>>> 3a4247aa481e0491c076340a8833dd32814a9466

	@Override
	public boolean registNewUser(UserVO newUserVO) {

		return userBiz.registNewUser(newUserVO);
	}

	@Override
	public List<UserVO> getAllUsers() {

		return userBiz.getAllUser();
	}

	@Override
	public UserVO getOneUser(String userId) {

		return userBiz.getOneUser(userId);
	}

	@Override
	public UserVO getOneUser(UserVO userVO) {

		return userBiz.getOneUser(userVO);
	}

	@Override
	public boolean updateUser(UserVO user) {

		UserVO tempUserVo = getOneUser(user.getUserId());
		if (user.getAuthorizationId() != null && user.getAuthorizationId().length() > 0) {
			tempUserVo.setAuthorizationId(user.getAuthorizationId());
		}
		if (user.getPassword() != null && user.getPassword().length() > 0) {
			tempUserVo.setPassword(user.getPassword());
		}
		return userBiz.updateUser(tempUserVo);
	}

	@Override
	public boolean deleteOneUser(String userId) {

		return userBiz.deleteOneUser(userId);
	}

	@Override
	public boolean changeUser(String beforeAuthorization, String afterAuthorization) {

		return userBiz.chagerUser(beforeAuthorization, afterAuthorization);
	}

	@Override
	public Map<String, Object> getOneUserWithAuthorizations(String userId) {
		// AuthorizationSearchVO authorizationSearchVO = new
		// AuthorizationSearchVO();
		// authorizationSearchVO.getPager().setPageNumber(0);

		Map<String, Object> user = new HashMap<String, Object>();
		user.put("user", userBiz.getOneUser(userId));
		// user.put("authorizations", authorizationBiz.)

		return null;
	}

<<<<<<< HEAD
	@Override
	public boolean isDuplicatedUserId(String userId) {
		System.out.println("ssws" + userId);
		return userBiz.isDuplicatedUserId(userId);
	}

=======
>>>>>>> 3a4247aa481e0491c076340a8833dd32814a9466
}
