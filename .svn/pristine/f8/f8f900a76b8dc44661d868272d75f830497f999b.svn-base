package kr.co.ta9.pandora3.app.util;

import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;

import com.amazonaws.ClientConfiguration;
import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.auth.InstanceProfileCredentialsProvider;
import com.amazonaws.services.kms.AWSKMS;
import com.amazonaws.services.kms.AWSKMSClientBuilder;
import com.amazonaws.services.kms.model.DecryptRequest;
import com.amazonaws.services.kms.model.DecryptResult;
import com.amazonaws.services.kms.model.EncryptRequest;
import com.amazonaws.services.kms.model.EncryptResult;
import com.amazonaws.services.kms.model.GenerateDataKeyRequest;
import com.amazonaws.util.Base64;

import kr.co.ta9.pandora3.common.conf.Configuration;

public final class KmsUtil {
	private static Configuration configuration = Configuration.getInstance();
	private  static String kmsKeyId = configuration.get("app.kms.key");
	private  static String cloudAwsRegionStatic = "ap-northeast-2";

	private KmsUtil() {
	    throw new IllegalStateException("Utility class");
	}


	 public static AWSKMS kmsClient() {
	        ClientConfiguration clientConfiguration = new ClientConfiguration();
	        // 최대 연결 수 설정
	        clientConfiguration.setMaxConnections(10);
	        // 연결 Timeout 최대 시간 설정 milliseconds 단위
	        clientConfiguration.setConnectionTimeout(6000);
	        // 요청 Timeout 최대 시간 설정 milliseconds 단위
	        clientConfiguration.setRequestTimeout(6000);


	        return AWSKMSClientBuilder.standard()
	                .withClientConfiguration(clientConfiguration)
	                .withCredentials(awsCredentialsProvider())
	                .withRegion(cloudAwsRegionStatic)
	                .build();
	    }

	public static String KmsEncrypt(String plainText){
		GenerateDataKeyRequest dataKeyRequest = new GenerateDataKeyRequest();
		dataKeyRequest.setKeyId(kmsKeyId);
		dataKeyRequest.setKeySpec("AES_256");

		AWSKMS kmsClient =kmsClient();
		EncryptResult encryptResult = kmsClient.encrypt(
	            new EncryptRequest()
	                    .withKeyId(kmsKeyId)
	                    .withPlaintext(ByteBuffer.wrap(plainText.getBytes(StandardCharsets.UTF_8)))
	    );

		String encString =extractString(ByteBuffer.wrap(Base64.encode(encryptResult.getCiphertextBlob().array())));
		 return encString;
	}

	public static String KmsDecrypt(String chiperText){

	    final ByteBuffer encryptedBytes = ByteBuffer.wrap(Base64.decode(chiperText.getBytes()));
		AWSKMS kmsClient =kmsClient();
	    DecryptResult decryptResult = kmsClient.decrypt(
	            new DecryptRequest()
	                    .withCiphertextBlob(encryptedBytes)
	    );
	    String decString =extractString(decryptResult.getPlaintext());
	    return decString;
	}

    public static String extractString(final ByteBuffer bb) {
        if (bb.hasRemaining()) {
            final byte[] bytes = new byte[bb.remaining()];
            bb.get(bytes, bb.arrayOffset(), bb.remaining());
            return new String(bytes);
        } else {
            return "";
        }
    }

    public static AWSCredentialsProvider awsCredentialsProvider() {
        // Argument > 자격증명을 비동기로 새로 발급 받아야할 경우 여부
        return new InstanceProfileCredentialsProvider(false);
    }


}
