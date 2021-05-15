// server.cpp : 此文件包含 "main" 函数。程序执行将在此处开始并结束。
//

#include <iostream>
#include <WinSock2.h>
#pragma comment(lib, "ws2_32.lib")

int tcp()
{
    WSADATA wsaData;
    bool needClean = 0 == WSAStartup(MAKEWORD(2, 2), &wsaData) ? true : false;

    SOCKET servSock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);

    {
        // 输入输出缓冲区大小 实验机器是 65535
        unsigned optVal;
        int len = sizeof(optVal);
        getsockopt(servSock, SOL_SOCKET, SO_SNDBUF, (char*)&optVal, &len);
        getsockopt(servSock, SOL_SOCKET, SO_RCVBUF, (char*)&optVal, &len);
    }
    sockaddr_in sockAddr;
    memset(&sockAddr, 0, sizeof(sockAddr));
    sockAddr.sin_family = PF_INET;
    sockAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    sockAddr.sin_port = htons(1234);
    bind(servSock, (sockaddr*)&sockAddr, sizeof(sockaddr));

    listen(servSock, 20);
    printf("listen...\n");
    sockaddr clntAddr;
    int nSize = sizeof(sockaddr);
    SOCKET clntSock = accept(servSock, &clntAddr, &nSize);
    printf("client conneted. \n");
    char buf[1024] = { 0 };
    FILE* pFile = _fsopen("log.txt", "wt", _SH_DENYNO);
    while (recv(clntSock, buf, sizeof(buf), NULL))
    {
        printf("recved: %s\nNow log to file\nNow send back...\n", buf);
        if (pFile != nullptr)
        {
            fprintf(pFile, "%s\n", buf);
        }
        fflush(pFile);
        send(clntSock, buf, sizeof(buf), NULL);
        memset(buf, 0, sizeof(buf));
    }

    printf("closing...\n");
    closesocket(clntSock);
    closesocket(servSock);
    if (pFile != nullptr) {
        fclose(pFile);
    }
    if (needClean)
    {
        WSACleanup();
    }
    return 0;
}
void udp()
{
    WSADATA wsaData;
    WSAStartup(MAKEWORD(2, 2), &wsaData);

    SOCKET sock = socket(PF_INET, SOCK_DGRAM, 0);

    sockaddr_in sockAddr;
    memset(&sockAddr, 0, sizeof(sockAddr));
    sockAddr.sin_family = PF_INET;
    sockAddr.sin_port = htons(1234);
    sockAddr.sin_addr.s_addr = htonl(INADDR_ANY);
    bind(sock, (sockaddr*)&sockAddr, sizeof(sockaddr));

    sockaddr clntAddr;
    int clntSize = sizeof(clntAddr);
    char buf[1024] = { 0 };
    FILE* pFile = _fsopen("recved.txt", "wt", _SH_DENYNO);
    while (true)
    {
        int len = recvfrom(sock, buf, sizeof(buf), NULL, &clntAddr, &clntSize);
        sockaddr_in* pAddr = (sockaddr_in*)&clntAddr;
        fprintf(pFile, "%s, client port: %d\n", buf, ntohs(pAddr->sin_port));
        fflush(pFile);
        sendto(sock, buf, sizeof(buf), NULL, &clntAddr, clntSize);
        if (!strcmp(buf, "quit"))
        {
            printf("quit...\n");
            break;
        }
        memset(buf, 0, sizeof(buf));
    }
    fclose(pFile);
    closesocket(sock);

    WSACleanup();
}
int main()
{
    
    udp();
}

